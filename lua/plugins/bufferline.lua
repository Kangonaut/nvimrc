-- [[ bufferline.nvim ]]
-- desc: display all buffers (in a similar way to tabs)
-- repo: https://github.com/akinsho/bufferline.nvim

return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      numbers = "ordinal",
      mode = "buffers",
      offsets = {
        {
          filetype = "neo-tree",
          text = "neo-tree",
          highlight = "tree",
          separator = true,
        },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    -- fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })

    -- [[ configure keymaps ]]
    -- cycling buffers
    vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCyclePrev<cr>", { desc = "prev buffer" })
    vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCycleNext<cr>", { desc = "next buffer" })
    vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "prev buffer" })
    vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "next buffer" })

    -- moving buffers
    vim.keymap.set("n", "[B", "<cmd>BufferLineMovePrev<cr>", { desc = "move previous buffer" })
    vim.keymap.set("n", "]B", "<cmd>BufferLineMoveNext<cr>", { desc = "move next buffer" })

    -- pin buffers
    vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "Toggle [B]uffer [P]in" })

    -- close buffers
    vim.keymap.set("n", "<leader>bco", "<cmd>BufferLineCloseOthers<cr>", { desc = "[B]uffer [C]lose [O]thers" })
    vim.keymap.set("n", "<leader>bcl", "<cmd>BufferLineCloseLeft<cr>", { desc = "[B]uffer [C]lose [L]eft" })
    vim.keymap.set("n", "<leader>bcr", "<cmd>BufferLineCloseRight<cr>", { desc = "[B]uffer [C]lose [R]ight" })
  end,
}
