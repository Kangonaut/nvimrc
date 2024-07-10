-- [[ none-ls.nvim ]]
-- desc: null-ls sources are able to hook into LSP features (code actions, diagnostics, formatting, ...)
-- repo: https://github.com/nvimtools/none-ls.nvim
-- NOTE: none-ls.nvim is a community maintained continuation of null-ls

return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    -- [[ configure formatters and linters ]]
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua, -- Lua formatter
      },
    })

    -- [[ configure keymaps ]]
    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[c]ode [f]ormat" })
  end,
}
