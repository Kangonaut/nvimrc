-- [[ which-key.nvim ]]
-- desc: displays popup with possible keybindings for the command you started typing
-- repo: https://github.com/folke/which-key.nvim

-- NOTE: event = 'VimEnter' loads which-key before all the UI elements are loaded

return {
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("which-key").setup()

      -- document existing key chains
      require("which-key").register({
        ["<leader>f"] = {
          name = "[f]ind",
          _ = "which_key_ignore",
          ["G"] = { name = "[G]it", _ = "which_key_ignore" },
        },
        ["<leader>c"] = { name = "[c]ode", _ = "which_key_ignore" },
        ["<leader>t"] = { name = "[t]oggle", _ = "which_key_ignore" },
        ["<leader>h"] = { name = "git [h]unk", _ = "which_key_ignore" },
        ["<leader>p"] = { name = "[p]ython", _ = "which_key_ignore" },
        ["<leader>b"] = {
          name = "[b]uffer",
          _ = "which_key_ignore",
          ["c"] = { name = "[c]lose", _ = "which_key_ignore" },
          ["s"] = { name = "[s]elect", _ = "which_key_ignore" },
        },
      })

      -- visual mode
      require("which-key").register({
        ["<leader>h"] = { "git [h]unk" },
      }, { mode = "v" })
    end,
  },
}
