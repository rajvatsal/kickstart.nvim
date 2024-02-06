return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<S-m>', desc = 'Add file to harpoon' },
    { '<TAB>', desc = 'Toggle harpoon' },
  },
  config = function()
    -- Set telescope as UI for harpoon
    local harpoon = require 'harpoon'
    harpoon:setup {}

    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    keymap('n', '<S-m>', "<cmd>lua require('vatsal.plugins.extras_harpoon').mark_file()<cr>", opts)

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
    (function()
      require('harpoon'):list():append()
    end)()
    vim.notify ' 󱡅  marked file'
  end,
}
