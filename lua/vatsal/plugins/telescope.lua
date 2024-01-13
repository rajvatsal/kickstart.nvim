return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
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
      desc = '[/] Fuzzily search in current buffer'
    },
    {
      '<leader>?',
      '<cmd>Telescope oldfiles<CR>',
      desc = '[?] Find recently opened files'
    },
    {
      '<leader>sf',
      '<cmd>Telescope find_files<CR>',
      desc = '[S]earch [F]iles'
    },
    {
      '<leader><space>',
      '<cmd>Telescope buffers<CR>',
      desc = 'Find exisiting buffers'
    },
    {
      '<leader>ss',
      '<cmd>Telescope builtin<CR>',
      desc = '[S]earch [S]elect Telescope'
    },
    {
      '<leader>gf',
      '<cmd>Telescope git_files<CR>',
      desc = 'Search [G]it [F]iles'
    },
    {
      '<leader>sh',
      '<cmd>Telescope help_tags<CR>',
      desc = '[S]earch [H]elp'
    },
    {
      '<leader>sw',
      '<cmd>Telescope grep_string<CR>',
      desc = '[S]earch current [W]ord'
    },
    {
      '<leader>sg',
      '<cmd>Telescope live_grep<CR>',
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>sd',
      '<cmd>Telescope diagnostics<CR>',
      desc = '[S]earch [D]iagnostics'
    },
    {
      '<leader>sr',
      '<cmd>Telescope resume<CR>',
      desc = '[S]earch [R]esume'
    },
  },

  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    }

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

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
      local git_root = vim.fn.systemlist('git -C ' ..
            vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')
          [1]
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
      require('telescope.builtin').live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end
    vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
    vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
  end,
}
