--[[ Options ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.hlsearch = false
vim.o.number = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.showbreak = '↳'
vim.o.breakindentopt = 'min:30,shift:1,sbr'
vim.o.breakindent = false
vim.o.undofile = true
vim.o.ignorecase = true -- for search
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 4
vim.o.expandtab = false
vim.o.relativenumber = true
vim.o.virtualedit = 'block'
vim.o.scrolloff = 10
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.list = true
vim.opt.listchars = { space = '󰧟', tab = '󰄾 ' }
vim.o.cursorline = true
vim.o.showmode = false
vim.o.wildignorecase = true
vim.o.wildignore = '*/node_modules/**,*/dist/**,*/__tests__/**,*/__test__/**,*/bin/**,*.spec.*,*.o,*.obj,*.log'

vim.g.netrw_winsize = 40
vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = 'exten'
vim.g.netrw_banner = 0

-- vim.o.foldmethod = 'indent'
-- vim.o.foldclose = 'all'

--
-- [[ Keymaps ]]
--

_G.HighlightStatus = true
local fn = vim.fn
local kmap = vim.keymap.set
local strf = string.format

kmap('n', '<leader>tt', function()
  vim.o.expandtab = not vim.o.expandtab
  print(strf("SET 'expandtab': %s", vim.o.expandtab))
end, { noremap = true, desc = '[T]oggle [T]ab', silent = true })

kmap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

kmap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
kmap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

kmap('n', '<C-i>', '<C-i>', { noremap = true, silent = true })

kmap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
kmap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
kmap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
kmap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

kmap('x', 'p', [["_dp]]) -- Don't update register when you paste over a word
kmap('n', '<leader>ta', '<cmd>KickstartFormatToggle<CR>', { noremap = true, silent = true, desc = '[T]oggle [A]utoformat' })
kmap('n', '<leader>th', function()
  if HighlightStatus then
    HighlightStatus = false
    vim.cmd 'LspStop'
    vim.cmd 'syntax off'
    vim.cmd 'TSBufDisable highlight'
  else
    HighlightStatus = true
    vim.cmd 'LspStart'
    vim.cmd 'syntax on'
    vim.cmd 'TSBufEnable highlight'
  end
end, { desc = '[T]oggle Syntax [H]ighlight', silent = true })

kmap('n', '<leader>mb', function()
  vim.cmd 'cd %:p:h'
  print('Moved to: ' .. vim.fn.expand '%:p:h')
end, { noremap = true, silent = true, desc = "[M]ove to current [B]uffer's path" })
kmap('n', '<leader>mg', function()
  local current_directory = vim.api.nvim_buf_get_name(0)
  local path_seperator = '/'

  -- If function is called outside of netrw
  if fn.isdirectory(current_directory) == 0 then
    current_directory = fn.fnamemodify(current_directory, ':p:h')
  end

  if fn.has 'win32' == 1 then
    path_seperator = '\\'
  end

  while current_directory and current_directory ~= vim.fn.fnamemodify(current_directory, ':p:h:h') do
    local git_path = current_directory .. path_seperator .. '.git'

    if fn.isdirectory(git_path) == 1 then
      vim.cmd('cd ' .. current_directory)
      print('Moved to: ' .. current_directory)
      return
    end
    current_directory = vim.fn.fnamemodify(current_directory, ':h')
  end

  print 'No git directory found'
end, { silent = true, noremap = true, desc = '[M]ove to [G]it Root' })

kmap('n', '<C-h>', function()
  local result = vim.treesitter.get_captures_at_cursor(0)
  print(vim.inspect(result))
end, { noremap = true, silent = false })

kmap({ 'n' }, '<Tab>', '<cmd>Lex<CR>', { noremap = true, desc = 'Open file exporer on cwd' })
kmap({ 'n' }, '<leader>tl', function()
  local is_open = _G.lex_open or false
  if is_open then
    vim.cmd 'Lex'
    _G.lex_open = false
  else
    vim.cmd 'Lex %:p:h'
    _G.lex_open = true
  end
end, { noremap = true, desc = "[T]oggle [L]ex in Current Buffer's directory" })

kmap('t', '<C-n>', '<C-\\><C-n>', { desc = 'exit terminal insert mode', silent = true, noremap = true })
kmap('t', "<C-'>", '<C-\\><C-n><C-w>', { desc = 'Move up a window', silent = true, noremap = true })
kmap('n', '<Leader>tf', function()
  local fc = vim.o.foldcolumn
  if fc == '0' then
    vim.o.foldcolumn = '4'
  else
    vim.o.foldcolumn = '0'
  end
end, { silent = true, noremap = true, desc = '[T]oggle [F]olds Column' })

kmap('n', '<leader>kb', function()
  local bash_command = vim.fn.input 'Command: '
  local buf = vim.api.nvim_create_buf(false, true)
  local prev_buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_set_current_buf(buf)
  vim.bo.bufhidden = 'wipe'
  vim.bo.buftype = 'nofile'
  vim.keymap.set('n', 'q', function()
    if vim.api.nvim_buf_is_valid(prev_buf) then
      vim.api.nvim_set_current_buf(prev_buf)
    else
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end, { buffer = buf, noremap = true, silent = true })
  vim.system({ 'sh', '-c', bash_command }, function(result)
    vim.schedule(function()
      local out
      if not (result.stderr == '') then
        out = vim.split(result.stderr, '\n')
        table.insert(out, 1, 'COMMAND RETURNED WITH ERROR')
        table.insert(out, 2, '')
        vim.api.nvim_buf_set_lines(buf, 1, -1, false, out)
      elseif result.stdout == '' then
        vim.api.nvim_buf_set_lines(buf, 1, -1, false, { 'NO OUTPUT FROM THE COMMAND' })
      else
        vim.api.nvim_buf_set_lines(buf, 1, -1, false, vim.split(result.stdout, '\n'))
      end
      vim.api.nvim_echo({}, false, {})
    end)
  end)
end, { noremap = true, desc = '[K]eymap To Run [B]ash Commands' })

kmap({ 'n' }, '<C-W>m', function()
  vim.cmd 'vert res'
  vim.cmd 'res'
end, { desc = '[M]aximize current window', noremap = true })

--
-- [[ Auto Commands ]]
--
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = {
    'netrw',
    'Jaq',
    'qf',
    'git',
    'help',
    'man',
    'lspinfo',
    'oil',
    'spectre_panel',
    'lir',
    'DressingSelect',
    'tsplayground',
    '',
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  callback = function()
    local clr = {
      primary = '#f5f500',
      string = '#529624',
      comment = 'orange',
      diagnostic_unused = '#545454',
      bg = '#181818',
      blue = '#00d5ff',
    }

    local set_hl = vim.api.nvim_set_hl

    -- Basic UI
    set_hl(0, 'Whitespace', { fg = '#343434' })
    set_hl(0, 'CursorLine', { bg = 'NONE' }) -- "transparent" == NONE
    set_hl(0, 'NormalFloat', { bg = clr.bg }) -- for which-key

    --[[ -- Treesitter comment variants
    set_hl(0, '@comment.todo', { bold = true, standout = true })
    set_hl(0, '@comment.error', { bold = true, italic = true, standout = true })
    set_hl(0, '@comment.note', { bold = true, italic = true, standout = true })

    -- Syntax
    set_hl(0, 'Keyword', { fg = clr.primary })
    set_hl(0, 'String', { fg = clr.string, italic = true })
    set_hl(0, '@comment', { fg = clr.comment })

    -- Cursor & line numbers
    set_hl(0, 'Cursor', {
      fg = 'black',
      bg = clr.primary,
    })

    set_hl(0, 'CursorLineNr', {
      fg = clr.primary,
      bg = 'NONE',
    }) ]]

    -- Cursor modes
    set_hl(0, 'iCursor', { fg = '#66ff00', bg = '#66ff00' })
    set_hl(0, 'vCursor', { fg = '#ff007f', bg = '#ff007f' })
    set_hl(0, 'rCursor', { fg = '#ffffff', bg = '#ffffff' })

    -- GUI cursor config (unchanged, already Lua)
    vim.opt.guicursor = 'a:Cursor/lCursor,'
      .. 'n-v-c-i:block,'
      .. 'n:blinkwait700-blinkoff400-blinkon250,'
      .. 'v-ve:vCursor,'
      .. 'i-ci:iCursor,'
      .. 'r-cr:rCursor,'
      .. 'sm:block-blinkwait175-blinkoff150-blinkon175'

    -- Fold
    -- vim.api.nvim_set_hl(0, 'FoldColumn', { fg = clr.primary, bg = 'NONE' })
    -- vim.api.nvim_set_hl(0, 'Folded', { fg = clr.blue, bg = 'NONE' })
  end,
  group = vim.api.nvim_create_augroup('ColorCustomizations', { clear = true }),
})

--[[ Plugins ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'tpope/vim-fugitive',
      'tpope/vim-rhubarb',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })

        -- Toggles
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end,
    },
  },

  -- debug.lua
  --
  -- Shows how to use the DAP plugin to debug your code.
  --
  -- Primarily focused on configuring the debugger for Go, but can
  -- be extended to other languages as well. That's why it's called
  -- kickstart.nvim and not kitchen-sink.nvim ;)
  {
    'mfussenegger/nvim-dap',
    lazy = false,
    dependencies = {
      -- Creates a beautiful debugger UI
      { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'theHamsta/nvim-dap-virtual-text',
    },
    keys = {
      { '<F5>', "<cmd>lua require('dap').continue()<CR>", { desc = 'Debug: Start/Continue' } },
    },
    config = function()
      local MASON_PATH = '~/.local/share/nvim/mason/packages'

      local dap = require 'dap'
      local dapui = require 'dapui'

      dap.configurations.go = {
        {
          type = 'delve',
          request = 'launch',
          program = '${file}',
          goPath = '/usr/bin/go',
          name = 'delve',
        },
      }

      require('dap').adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          -- 💀 Make sure to update this path to point to your installation
          args = { MASON_PATH .. 'js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
        },
      }

      require('dap').configurations.javascript = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to Node app',
          address = 'localhost',
          port = 9229,
          cwd = '${workspaceFolder}',
          restart = true,
        },
      }

      dap.configurations.cpp = {
        {
          type = 'gdb',
          request = 'launch',
          program = '${file}',
          MIMode = 'gdb',
          miDebuggerPath = '/usr/bin/gdb',
          name = 'Cpp linux (single file)',
        },
      }

      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- Add these to stop missing fields message
        MasonNvimDapSettings = {},
        automatic_installation = false,

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'delve',
          'codelldb',
          'gdb',
          'js-debug-adapter',
        },
      }

      -- Basic debugging keymaps, feel free to change to your liking!
      -- vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Breakpoint' })

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },
  {
    -- "gc" to comment visual regions/lines
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'InsertEnter' },
    opts = {},
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvimtools/none-ls-extras.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
    config = function()
      local nls = require 'null-ls.builtins'

      local clang = { filetypes = { 'c' } }
      require('null-ls').setup {
        sources = {
          nls.diagnostics.stylelint,
          nls.formatting.stylua,
          nls.formatting.prettierd,
          nls.formatting.clang_format.with(clang),
          nls.formatting.black,
          -- require 'none-ls.diagnostics.eslint_d',
        },
      }
    end,
  },
  {
    'stevearc/overseer.nvim',
    cmd = 'OverseerRun',
    keys = {
      { '<leader>po', '<cmd>OverseerRun<CR>', desc = '[P]ackage using [O]verseer' },
    },
    opts = {
      templates = { 'builtin', 'cpp.SingleFile_debug', 'cpp.SingleFile_release' },
      strategy = 'toggleterm',
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
    enabled = true,
    opts = function()
      local Lualine_Clrs = {
        green = '#66ff00', -- '#6eb93b',
        red = '#EB212E', -- '#d73a49',
        darkgrey = '#a2a2a3',
        darkgrey_700 = '#545454 ',
        darkyellow = '#f2bb22',
        purple = '#ff007f', -- '#f542a7',
        white = '#f7f7f7',
        black = '#181818',
      }

      local function getFileName(f_name)
        local isNotCreated = f_name:find 'No Name'
        if isNotCreated == nil then
          return f_name
        else
          return '*new*'
        end
      end

      return {
        options = {
          theme = {
            normal = {
              a = { fg = Lualine_Clrs.red, bg = Lualine_Clrs.black },
              b = { fg = Lualine_Clrs.darkgrey, bg = Lualine_Clrs.black },
              c = { fg = Lualine_Clrs.white, bg = Lualine_Clrs.black },
              x = { fg = Lualine_Clrs.darkgrey_700, bg = Lualine_Clrs.black },
              y = { bg = Lualine_Clrs.black },
              z = { fg = Lualine_Clrs.white, bg = Lualine_Clrs.black },
            },

            insert = {
              a = { fg = Lualine_Clrs.green, bg = Lualine_Clrs.black },
              b = { fg = Lualine_Clrs.darkgrey, bg = Lualine_Clrs.black },
              c = { fg = Lualine_Clrs.white, bg = Lualine_Clrs.black },
              x = { fg = Lualine_Clrs.darkgrey_700, bg = Lualine_Clrs.black },
              y = { bg = Lualine_Clrs.black },
              z = { fg = Lualine_Clrs.green, bg = Lualine_Clrs.black },
            },

            visual = {
              a = { fg = Lualine_Clrs.purple, bg = Lualine_Clrs.black },
              b = { fg = Lualine_Clrs.purple, bg = Lualine_Clrs.black },
              c = { fg = Lualine_Clrs.white, bg = Lualine_Clrs.black },
              x = { fg = Lualine_Clrs.darkgrey_700, bg = Lualine_Clrs.black },
              y = { bg = Lualine_Clrs.black },
              z = { fg = Lualine_Clrs.purple, bg = Lualine_Clrs.black },
            },

            command = {
              a = { fg = Lualine_Clrs.darkgrey_700, bg = Lualine_Clrs.black },
              b = { fg = Lualine_Clrs.darkgrey_700, bg = Lualine_Clrs.black },
              c = { fg = Lualine_Clrs.white, bg = Lualine_Clrs.black },
              x = { fg = Lualine_Clrs.darkgrey_700, bg = Lualine_Clrs.black },
              y = { bg = Lualine_Clrs.black },
              z = { fg = Lualine_Clrs.black, bg = Lualine_Clrs.white },
            },

            inactive = {
              a = { fg = Lualine_Clrs.darkgrey, bg = Lualine_Clrs.black },
              b = { fg = Lualine_Clrs.darkgrey, bg = Lualine_Clrs.black },
              c = { fg = Lualine_Clrs.darkgrey, bg = Lualine_Clrs.black },
              x = { fg = Lualine_Clrs.darkgrey_700, bg = Lualine_Clrs.black },
              y = { bg = Lualine_Clrs.black },
              z = { fg = Lualine_Clrs.white, bg = Lualine_Clrs.black },
            },
          },
          disabled_filetypes = { 'NvimTree' },
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          globalstatus = true,
          always_show_tabline = false,
        },
        sections = {
          lualine_a = {
            {
              'mode',
              fmt = function()
                return ''
              end,
            },
          },
          lualine_b = {
            {
              'filename',
              fmt = getFileName,
              color = { fg = Lualine_Clrs.white, gui = 'bold' },
            },
            { 'hostname' },
            { 'branch' },
          },
          lualine_c = {},
          lualine_x = { { 'diagnostics', count = false } },
          lualine_y = {
            {
              'diff',
              colored = true, -- Displays a colored diff status if set to true
              diff_color = {
                add = 'LuaLineDiffAdd', -- Changes the diff's added color
                modify = 'LuaLineDiffChange', -- Changes the diff's modified color
                remove = 'LuaLineDiffDelete', -- Changes the diff's removed color you
              },
              symbols = { added = '+', modified = '~', removed = '-' },
            },
          },
          lualine_z = {
            { 'progress', separator = '' },
            { 'location' },
          },
        },
        tabline = {
          lualine_a = {
            {
              'tabs',
              mode = 2,
              max_length = vim.o.columns,
              tabs_color = {
                active = 'TabLineSel',
                inactive = 'lualine_a_normal',
              },
              fmt = getFileName,
            },
          },
        },
      }
    end,
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    event = { 'InsertEnter' },
    config = function()
      -- [[ Configure nvim-cmp ]]
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = 'true',
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
    keys = {
      { '<leader>tt', '<cmd>NvimTreeToggle .<CR>', { noremap = true, silent = true }, desc = 'toggle file tree' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    --[[ init = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = 'NvimTree',
      command = ":lua require('gitsigns').detach()"
    })
    end, ]]
    opts = {
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        width = 38,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    },
    {
      'folke/which-key.nvim',
      event = 'VeryLazy',
      opts = { icons = { mappings = false, rules = false } },
      config = function(_, opts)
        local wk = require 'which-key'
        -- document existing key chains
        wk.add {
          { '<leader>c', group = '[C]ode' },
          { '<leader>d', group = '[D]ocument' },
          { '<leader>g', group = '[G]it' },
          { '<leader>m', group = '[M]ove' },
          { '<leader>p', group = '[P]ackage' },
          { '<leader>h', group = 'Git [H]unk' },
          { '<leader>r', group = '[R]ename' },
          { '<leader>s', group = '[S]earch' },
          { '<leader>t', group = '[T]oggle' },
          { '<leader>w', group = '[W]orkspace' },
        }
        -- register which-key VISUAL mode
        -- required for visual <leader>hs (hunk stage) to work
        wk.add {
          { '<leader>', group = 'VISUAL <leader>' },
          { '<leader>h', group = 'Git [H]unk', mode = 'v' },
        }
        wk.setup(opts)
      end,
    },
    {
      -- Detect tabstop and shiftwidth automatically
      'tpope/vim-sleuth',
      event = { 'BufReadPre', 'BufNewFile' },
      enabled = false,
    },
    {
      'stevearc/oil.nvim',
      keys = { { '<leader>to', '<cmd>Oil --float<CR>', desc = 'toggle oil' } },
      opts = {
        float = {
          max_height = 20,
          max_width = 80,
        },
      },
    },
    {
      -- Fuzzy Finder (files, lsp, etc)
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = {
        { 'nvim-lua/plenary.nvim' },
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          -- NOTE: If you are having trouble with this installation,
          --       refer to the README for telescope-fzf-native for more instructions.
          build = 'make',
          cond = function()
            return vim.fn.executable 'make' == 1
          end,
        },
      },
      cmd = 'Telescope',
      keys = {
        {
          '<leader>/',
          -- See `:help telescope.builtin`
          function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
              winblend = 10,
              previewer = false,
            })
          end,
          desc = '[/] Fuzzily search in current buffer',
        },
        {
          '<leader>?',
          '<cmd>Telescope oldfiles<CR>',
          desc = '[?] Find recently opened files',
        },
        {
          '<leader>sf',
          '<cmd>Telescope find_files<CR>',
          desc = '[S]earch [F]iles',
        },
        {
          '<leader><space>',
          '<cmd>Telescope buffers<CR>',
          desc = 'Find exisiting buffers',
        },
        {
          '<leader>ss',
          '<cmd>Telescope builtin<CR>',
          desc = '[S]earch [S]elect Telescope',
        },
        {
          '<leader>gf',
          '<cmd>Telescope git_files<CR>',
          desc = 'Search [G]it [F]iles',
        },
        {
          '<leader>sh',
          '<cmd>Telescope help_tags<CR>',
          desc = '[S]earch [H]elp',
        },
        {
          '<leader>sw',
          '<cmd>Telescope grep_string<CR>',
          desc = '[S]earch current [W]ord',
        },
        {
          '<leader>sg',
          '<cmd>Telescope live_grep<CR>',
          desc = '[S]earch by [G]rep',
        },
        {
          '<leader>sd',
          '<cmd>Telescope diagnostics<CR>',
          desc = '[S]earch [D]iagnostics',
        },
        {
          '<leader>sr',
          '<cmd>Telescope resume<CR>',
          desc = '[S]earch [R]esume',
        },
      },

      opts = {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      },
      config = function()
        local ts = require 'telescope'

        -- Enable telescope fzf native, if installed
        pcall(ts.load_extension, 'fzf')

        -- Telescope live_grep in git root
        -- Function to find the git root directory based on the current buffer's path
        local function find_git_root()
          -- Use the current buffer's path as the starting point for the git search
          local current_file = vim.api.nvim_buf_get_name(0)
          local current_dir
          local cwd = vim.fn.getcwd()
          -- If the buffer is not associated with a file, return nil
          if current_file == '' then
            current_dir = cwd
          else
            -- Extract the directory from the current file's path
            current_dir = vim.fn.fnamemodify(current_file, ':h')
          end

          -- Find the Git root directory from the current file's path
          local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
          if vim.v.shell_error ~= 0 then
            print 'Not a git repository. Searching on current working directory'
            return cwd
          end
          return git_root
        end

        -- Custom live_grep function to search in git root
        local function live_grep_git_root()
          local git_root = find_git_root()
          if git_root then
            require('telescope.builtin').live_grep {
              search_dirs = { git_root },
            }
          end
        end

        vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

        local function telescope_live_grep_open_files()
          ts.builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end
        vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
        vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
      end,
    },
    {
      'akinsho/toggleterm.nvim',
      version = '*',
      keys = '<C-t>',
      cmd = 'TermExec',
      enabled = false,
      opts = {
        size = 12,
        open_mapping = '<C-t>',
        direction = 'float',
        auto_scroll = true,
        float_opts = {
          border = 'curved',
        },
        highlights = {
          NormalFloat = {
            -- guibg = '#000000',
          },
          FloatBorder = {
            -- guibg = '#000000',
            guifg = '#494949',
          },
        },
        autochdir = true,
        shade_terminals = true,

        shell = 'tmux',
      },
    },
    {
      'tjdevries/colorbuddy.nvim',
      config = function()
        -- local Color, colors, Group, groups, styles = require('colorbuddy').setup()
        -- Pallet: https://base16.vercel.app/previews/base16-twilight
        -- https://github.com/goolord/alpha-nvim/discussions/16#:~:text=I%27m%20not%20quite%20satisfied%20with%20the%20layout%20yet%2C%20I%20started%20out%20with%20some%20colours%20but%20ended%20up%20omitting%20them%20for%20simplicity.%20Here%27s%20what%20it%20looks%20like%20so%20far%3A
      end,
    },
    {
      'xiyaowong/transparent.nvim',
      lazy = false,
      cmd = {
        'TransparentEnable',
        'TransparentToggle',
      },
    },
  },
  { 'MaximilianLloyd/ascii.nvim', dependencies = 'MunifTanjim/nui.nvim' },
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    enabled = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<S-m>', desc = 'Add file to harpoon' },
      { '<TAB>', desc = 'Toggle harpoon' },
    },
    config = function(plug)
      -- Set telescope as UI for harpoon
      local harpoon = require 'harpoon'
      harpoon:setup {}

      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      keymap('n', '<S-m>', plug.mark_file, opts)

      -- basic telescope configuration
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set('n', '<TAB>', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'Open harpoon window' })
    end,
    mark_file = function()
      local harpoon = require 'harpoon'
      local matched = false
      for _, v in pairs(harpoon:list().items) do
        local harpooned = v.value
        local current_file = vim.fn.expand '%'
        if harpooned:match(current_file) then
          matched = true
          break
        end
      end
      if matched then
        harpoon:list():remove()
        vim.notify ' 󱡅  unmarked file'
      else
        harpoon:list():add()
        vim.notify ' 󱡅  marked file'
      end
    end,
  },
  {
    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    -- LSP Configuration & Plugins

    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        'mason-org/mason.nvim',
        opts = {
          ui = {
            icons = {
              package_installed = '󰔶',
              package_pending = '➜',
              package_uninstalled = '',
            },
          },
        },
        dependencies = {
          {
            'stevearc/dressing.nvim',
            init = function()
              ---@diagnostic disable-next-line: duplicate-set-field
              vim.ui.select = function(...)
                require('lazy').load { plugins = { 'dressing.nvim' } }
                return vim.ui.select(...)
              end
              ---@diagnostic disable-next-line: duplicate-set-field
              vim.ui.input = function(...)
                require('lazy').load { plugins = { 'dressing.nvim' } }
                return vim.ui.input(...)
              end
            end,
          },
        },
        cmd = 'Mason',
      },
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
          ensure_installed = {
            'eslint_d',
            'prettierd',
            'stylua',
          },
          auto_update = true,
        },
        config = function(_, opts)
          require('mason-tool-installer').setup(opts)
          vim.cmd 'MasonToolsInstall'
        end,
      },
      'mason-org/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        'j-hui/fidget.nvim',
        opts = { notification = { window = { avoid = { 'NvimTree' } } } },
        config = function(_, opts)
          vim.notify = require('fidget').notify
          require('fidget').setup(opts)
        end,
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- [[ Configure LSP ]]
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction') Lazyload on keyaction

        nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end

      -- mason-lspconfig requires that these setup functions are called in this order
      -- before setting up the servers.
      require('mason').setup()
      require('mason-lspconfig').setup()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. They will be passed to
      --  the `settings` field of the server config. You must look up that documentation yourself.
      --
      --  If you want to override the default filetypes that your language server will attach to you can
      --  define the property 'filetypes' to the map in question.
      local servers = {
        clangd = {},
        ts_ls = {},
        rust_analyzer = {},
        html = { filetypes = { 'html' } },

        lua_ls = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      }

      -- Setup neovim lua configuration
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      -- Newer way to handle servers
      for server_name, config in pairs(servers) do
        vim.lsp.config(server_name, {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = config,
          filetypes = config.filetypes,
        })
      end

      -- Autoformatting [[It used to be a separate autoformat.lua file but for some reason it wasn't working]]
      -- Switch for controlling whether you want autoformatting.
      --  Use :KickstartFormatToggle to toggle autoformatting on or off
      local format_is_enabled = true
      vim.api.nvim_create_user_command('KickstartFormatToggle', function()
        format_is_enabled = not format_is_enabled
        print('Setting autoformatting to: ' .. tostring(format_is_enabled))
      end, {})

      -- Create an augroup that is used for managing our formatting autocmds.
      --      We need one augroup per client to make sure that multiple clients
      --      can attach to the same buffer without interfering with each other.
      local _augroups = {}
      local get_augroup = function(client)
        if not _augroups[client.id] then
          local group_name = 'kickstart-lsp-format-' .. client.name
          local id = vim.api.nvim_create_augroup(group_name, { clear = true })
          _augroups[client.id] = id
        end

        return _augroups[client.id]
      end

      -- Whenever an LSP attaches to a buffer, we will run this function.
      --
      -- See `:help LspAttach` for more information about this autocmd event.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
        -- This is where we attach the autoformatting for reasonable clients
        callback = function(args)
          local client_id = args.data.client_id
          local client = vim.lsp.get_client_by_id(client_id)
          local bufnr = args.buf

          -- Only attach to clients that support document formatting
          if not client.server_capabilities.documentFormattingProvider then
            return
          end

          -- Tsserver usually works poorly. Sorry you work with bad languages
          -- You can remove this line if you know what you're doing :)
          if client.name == 'tsserver' then
            return
          end

          -- Create an autocmd that will run *before* we save the buffer.
          --  Run the formatting command for the LSP that has just attached.
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = get_augroup(client),
            buffer = bufnr,
            callback = function()
              if not format_is_enabled then
                return
              end

              vim.lsp.buf.format {
                async = false,
                filter = function(c)
                  return c.id == client.id
                end,
              }
            end,
          })
        end,
      })
    end,
  },
  {
    'karb94/neoscroll.nvim',
    enabled = false,
    keys = {
      { '<C-D>' },
      { '<C-U>' },
    },
    config = true,
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-treesitter.install').compilers = { 'zig', 'gcc' }

      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
      vim.defer_fn(function()
        require('nvim-treesitter.configs').setup {
          -- Add languages to be installed here that you want installed for treesitter
          ensure_installed = {
            'c',
            'cpp',
            'go',
            'lua',
            'python',
            'rust',
            'tsx',
            'javascript',
            'typescript',
            'vimdoc',
            'vim',
            'bash',
            'markdown',
            'html',
            'css',
          },

          -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
          auto_install = false,
          -- Install languages synchronously (only applied to `ensure_installed`)
          sync_install = false,
          -- List of parsers to ignore installing
          ignore_install = {},
          -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
          modules = {},
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<c-space>',
              node_incremental = '<c-space>',
              scope_incremental = '<c-s>',
              node_decremental = '<M-space>',
            },
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
              },
              goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
              },
              goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
              },
              goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ['<leader>a'] = '@parameter.inner',
              },
              swap_previous = {
                ['<leader>A'] = '@parameter.inner',
              },
            },
          },
        }
      end, 0)
    end,
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    dependencies = { 'HiPhish/rainbow-delimiters.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    main = 'ibl',
    enabled = false,
    opts = {
      whitespace = { highlight = { 'Cursor' } },
      scope = { highlight = { 'MoreMsg' }, char = '▎', show_start = false, show_end = false },
      exclude = {
        buftypes = { 'dashboard', 'alpha', 'help', 'lazy', 'mason' },
      },
    },
    config = function(_, opts)
      -- You can set custom hilight like this
      -- vim.api.nvim_set_hl(0, 'indent-line', { bg = 'none', fg = '#891919' })
      opts.scope.highlight = { 'RainbowDelimiterRed' }

      require('ibl').setup(opts)
    end,
  },
  {
    'christoomey/vim-tmux-navigator',
    enabled = false,
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    keys = { { '<leader>ca', vim.lsp.buf.code_action, desc = '[C]ode [A]ction' } },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
        },
      }
      require('telescope').load_extension 'ui-select'
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    keys = {
      { '<leader>tm', '<cmd>MarkdownPreviewToggle<CR>', desc = 'toggle markdown preview' },
    },
    build = function()
      require('lazy').load { plugins = { 'markdown-preview.nvim' } }
      vim.fn['mkdp#util#install']()
    end,
    init = function()
      -- vim.g.mkdp_filetypes = { 'markdown' }
      -- vim.g.mkdp_auto_close = 0
      -- vim.g.mkdp_command_for_global = 1
      -- vim.g.mkdp_combine_preview = 1
      --
      -- local function load_then_exec(cmd)
      --   return function()
      --     vim.cmd.delcommand(cmd)
      --     require('lazy').load { plugins = { 'markdown-preview.nvim' } }
      --     vim.api.nvim_exec_autocmds('BufEnter', {}) -- commands appear only after BufEnter
      --     vim.cmd(cmd)
      --   end
      -- end
      --
      -- ---Fixes "No command :MarkdownPreview"
      -- ---https://github.com/iamcco/markdown-preview.nvim/issues/585#issuecomment-1724859362
      -- for _, cmd in pairs { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' } do
      --   vim.api.nvim_create_user_command(cmd, load_then_exec(cmd), {})
      -- end
    end,
  },
  {
    'mcauley-penney/visual-whitespace.nvim',
    config = true,
    event = 'ModeChanged *:[vV\22]', -- optionally, lazy load on entering visual mode
    opts = {
      enabled = true,
      match_types = {
        space = true,
        tab = false,
        nbsp = false,
      },
      list_chars = {
        space = '',
      },
      fileformat_chars = {
        unix = '',
        mac = '',
        dos = '',
      },
    },
  },
  {
    'Eandrju/cellular-automaton.nvim',
    cmd = 'CellularAutomaton',
  },
  { 'BlakeJC94/alpha-nvim-fortune' },
  {
    'goolord/alpha-nvim',
    enabled = true,
    event = 'VimEnter',
    cmd = 'Alpha',
    config = function(plugin)
      plugin.get_alpha_config().startify()
    end,
    get_alpha_config = function()
      local function convert_path_notation(file_path)
        return string.gsub(file_path, '%.', '/')
      end

      local function check_if_file_exists(file_path)
        file_path = vim.fn.stdpath 'config' .. '/lua/' .. convert_path_notation(file_path) .. '.lua'
        local file, err = io.open(file_path)
        if file then
          return true
        end
        return false
      end

      local function conditional_require(file_path)
        if check_if_file_exists(file_path) then
          return require(file_path)
        else
          return false
        end
      end

      --[[ ascii art config ]]
      local ascii_art = conditional_require 'misc.ascii-arts'
      local function get_ascii_art(art_name)
        if not ascii_art or art_name == nil then
          return {
            [[         ,--.                                                        ]],
            [[       ,--.'|                                                 ____   ]],
            [[   ,--,:  : |                                ,--,           ,'  , `. ]],
            [[,`--.'`|  ' :             ,---.            ,--.'|        ,-+-,.' _ | ]],
            [[|   :  :  | |            '   ,'\      .---.|  |,      ,-+-. ;   , || ]],
            [[:   |   \ | :   ,---.   /   /   |   /.  ./|`--'_     ,--.'|'   |  || ]],
            [[|   : '  '; |  /     \ .   ; ,. : .-' . ' |,' ,'|   |   |  ,', |  |, ]],
            [['   ' ;.    ; /    /  |'   | |: :/___/ \: |'  | |   |   | /  | |--'  ]],
            [[|   | | \   |.    ' / |'   | .; :.   \  ' .|  | :   |   : |  | ,     ]],
            [['   : |  ; .''   ;   /||   :    | \   \   ''  : |__ |   : |  |/      ]],
            [[|   | '`--'  '   |  / | \   \  /   \   \   |  | '.'||   | |`-'       ]],
            [['   : |      |   :    |  `----'     \   \ |;  :    ;|   ;/           ]],
            [[;   |.'       \   \  /               '---" |  ,   / '---'            ]],
            [['---'          `----'                       ---`-'                   ]],
          }
        end
        return ascii_art[art_name]
      end

      --[[ alpha configs ]]
      local alpha_config = {}
      alpha_config['dashboard'] = function()
        local ascii = require 'ascii'
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'

        -- Set header uses the config
        dashboard.section.header.val = ascii.art.misc.krakens.krakedking

        -- Set menu
        dashboard.section.buttons.val = {
          dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
          dashboard.button('r', '  Recently used files', ':Telescope oldfiles<CR>'),
          dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
          dashboard.button('t', '  Find text', ':Telescope live_grep <CR>'),
          dashboard.button('q', '  Quit NVIM', ':qa<CR>'),
        }

        -- Set footer
        -- dashboard.section.footer.val = require('alpha.fortune')()

        -- Colors

        dashboard.section.header.opts.hl = 'String'
        dashboard.section.buttons.opts.hl = 'Debug'
        dashboard.section.footer.opts.hl = 'white'
        dashboard.config.opts.noautocmd = true

        vim.cmd [[autocmd User AlphaReady echo 'ready']]

        alpha.setup(dashboard.opts)
        -- Plugins loaded footer
        vim.api.nvim_create_autocmd('User', {
          once = true,
          pattern = 'LazyVimStarted',
          callback = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            dashboard.section.footer.val = '⚡Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
            pcall(vim.cmd.AlphaRedraw)
          end,
        })
      end

      alpha_config['startify'] = function()
        local fortune = require 'alpha.fortune'
        local alpha = require 'alpha'
        local startify = require 'alpha.themes.startify'

        startify.section.header.val = get_ascii_art()

        startify.config.layout[1].val = 2
        startify.config.layout[3].val = 2

        startify.section.top_buttons.val = {
          startify.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
          startify.button('r', '  Recently used files', ':Telescope oldfiles<CR>'),
          startify.button('t', '󰈞  Find text', ':Telescope live_grep <CR>'),
        }

        -- disable MRU
        startify.section.mru.val = { { type = 'padding', val = 0 } }
        -- disable MRU cwd
        startify.section.mru_cwd.val = { { type = 'padding', val = 0 } }
        -- disable nvim_web_devicons
        startify.nvim_web_devicons.enabled = false
        -- startify.nvim_web_devicons.highlight = false
        -- startify.nvim_web_devicons.highlight = 'Keyword'

        startify.section.bottom_buttons.val = {
          startify.button('q', '󰅚  Quit NVIM', ':qa<CR>'),
          { type = 'padding', val = 2 },
        }

        vim.api.nvim_set_hl(0, 'FooterStartify', { fg = '#8A94BC' })
        startify.section.footer.val = { { type = 'text', val = fortune(), opts = { hl = 'FooterStartify', margin = 30 } } }

        -- ignore filetypes in MRU
        startify.mru_opts.ignore = function(path, ext)
          return (string.find(path, 'COMMIT_EDITMSG')) or (vim.tbl_contains(default_mru_ignore, ext))
        end
        alpha.setup(startify.config)
      end
      return alpha_config
    end,
  },
  {
    --[[ colorscheme ]]
    'blazkowolf/gruber-darker.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme 'gruber-darker'
    end,
  },
  --[[ extra colorschemes ]]
  -- require 'vatsal.colorschemes',
}, {
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        'tutor',
      },
    },
  },
})
