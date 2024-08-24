-- [[ outline.nvim ]]
-- desc: sidebar with tree-like outline of symbols from your code, powered by LSP
-- repo: https://github.com/hedyhli/outline.nvim

return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
  opts = {
    -- Your setup opts here
  },
}
