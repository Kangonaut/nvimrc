-- [[ venv-selector.nvim ]]
-- desc: allows selection of python virtual environment
-- repo: https://github.com/linux-cultist/venv-selector.nvim

return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp", -- Use this branch for the new version
  cmd = "VenvSelect",
  lazy = false,

  opts = {
    settings = {
      options = {
        notify_user_on_venv_activation = true,
      },
    },
  },

  --  call config for python files and load the cached venv automatically
  ft = "python",

  keys = {
    { "<leader>pv", "<cmd>VenvSelect<cr>", desc = "[p]ython [v]irtual environment", ft = "python" },
  },
}
