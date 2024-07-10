-- [[ todo-comments.nvim ]]
-- desc: highlight TODO (and similar) comments
-- repo: https://github.com/folke/todo-comments.nvim

-- NOTE: this is a example
return {
  "folke/todo-comments.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    signs = false,
  },
}
