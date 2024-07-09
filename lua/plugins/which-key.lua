-- [[ which-key.nvim ]]
-- desc: displays popup with possible keybindings for the command you started typing
-- repo: https://github.com/folke/which-key.nvim

-- NOTE: event = 'VimEnter' loads which-key before all the UI elements are loaded

return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      -- document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
        ["<leader>b"] = { 
          name = "[B]uffer",
          _ = "which_key_ignore",

          ["c"] = { name = "[B]uffer [C]lose", _ = "which_key_ignore" }
        }
      }

      -- visual mode
      require('which-key').register({
        ['<leader>h'] = { 'Git [H]unk' },
      }, { mode = 'v' })
    end,
  },
}
