-- [[ indent-blankline.nvim ]]
-- desc: add indentation guides
-- repo: https://github.com/lukas-reineke/indent-blankline.nvim

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "|",
        tab_char = "|",
      },
      scope = {
        show_start = false,
        show_end = false,
      },
    },
  },
}
