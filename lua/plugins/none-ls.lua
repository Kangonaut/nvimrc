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
      -- NOTE: don't forget to install these sources using mason first (by adding them to the `ensure_installed` property)
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,

        -- Python
        null_ls.builtins.formatting.black,

        -- Spelling
        null_ls.builtins.diagnostics.codespell, -- fix common spelling mistakes

        -- Markdown
        null_ls.builtins.formatting.markdownlint,
      },
    })

    -- [[ configure keymaps ]]
    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[f]ormat" })
  end,
}
