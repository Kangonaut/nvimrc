-- [[ leetcode.nvim ]]
-- desc: solve LeetCode problems inside Neovim
-- repo: https://github.com/kawre/leetcode.nvim

local arg = "leetcode.nvim"

return {
  "kawre/leetcode.nvim",

  -- NOTE: loads the plugin on startup if nvim is called like this: `nvim leetcode.nvim`
  lazy = arg ~= vim.fn.argv()[1],

  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    arg = arg,

    ---@type lc.lang
    lang = "python3",

    ---@type boolean
    image_support = true,

    keys = {
      ---@type string
      reset_testcases = "R",
    },
  },
}
