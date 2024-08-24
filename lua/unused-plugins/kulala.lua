-- [[ kulala.nvim ]]
-- desc: a minimal HTTP client interface for Neovim
-- repo: https://github.com/mistweaverco/kulala.nvim

return {
  "mistweaverco/kulala.nvim",
  opts = {
    formatters = {
      json = { "jq", "." },
      xml = { "biome", "format", "--stdin-file-path", "$FILENAME" },
      html = { "biome", "format", "--stdin-file-path", "$FILENAME" },
    },
  },
  config = function(_, opts)
    vim.filetype.add({
      extension = {
        ["http"] = "http",
      },
    })

    -- Setup is required, even if you don't pass any options
    require("kulala").setup(opts)
  end,
}
