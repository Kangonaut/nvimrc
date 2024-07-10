-- [[ mini.nvim ]]
-- desc: library of 40+ independent Lua modules
-- repo: https://github.com/echasnovski/mini.nvim

return {
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [v]isually select [a]round [)]paren
      --  - yinq - [y]ank [i]nside [n]ext [']quote
      --  - ci'  - [c]hange [i]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- Examples:
      -- - saiw) - [s]urround [a]dd [i]nner [w]ord [)]Paren
      -- - sd'   - [s]urround [d]elete [']quotes
      -- - sr)'  - [s]urround [r]eplace [)] [']
      require("mini.surround").setup()
    end,
  },
}
