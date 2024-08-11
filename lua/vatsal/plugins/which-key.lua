return {
  -- Useful plugin to show you pending keybinds.
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
      { '<leader>b', group = '[B]uild' },
      { '<leader>h', group = 'Git [H]unk' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>w', group = '[W]orkspace' },
    }
    -- register which-key VISUAL mode
    -- required for visual <leader>hs (hunk stage) to work
    wk.add {
      { '<leader>',  group = 'VISUAL <leader>' },
      { '<leader>h', group = 'Git [H]unk',     mode = 'v' },
    }
  end,
}
