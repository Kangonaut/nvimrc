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
    vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "prev buffer" })
    vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "next buffer" })
    vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "prev buffer" })
    vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "next buffer" })

    -- select specific buffer
    vim.keymap.set("n", "<leader>bs1", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "[1]" })
    vim.keymap.set("n", "<leader>bs2", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "[2]" })
    vim.keymap.set("n", "<leader>bs3", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "[3]" })
    vim.keymap.set("n", "<leader>bs4", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "[4]" })
    vim.keymap.set("n", "<leader>bs5", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "[5]" })
    vim.keymap.set("n", "<leader>bs6", "<cmd>BufferLineGoToBuffer 6<cr>", { desc = "[6]" })
    vim.keymap.set("n", "<leader>bs7", "<cmd>BufferLineGoToBuffer 7<cr>", { desc = "[7]" })
    vim.keymap.set("n", "<leader>bs8", "<cmd>BufferLineGoToBuffer 8<cr>", { desc = "[8]" })
    vim.keymap.set("n", "<leader>bs9", "<cmd>BufferLineGoToBuffer 9<cr>", { desc = "[9]" })

    -- moving buffers
    vim.keymap.set("n", "[B", "<cmd>BufferLineMovePrev<cr>", { desc = "move previous buffer" })
    vim.keymap.set("n", "]B", "<cmd>BufferLineMoveNext<cr>", { desc = "move next buffer" })

    -- pin buffers
    vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "toggle [p]in" })

    -- close buffers
    vim.keymap.set("n", "<leader>bco", "<cmd>BufferLineCloseOthers<cr>", { desc = "[o]thers" })
    vim.keymap.set("n", "<leader>bcl", "<cmd>BufferLineCloseLeft<cr>", { desc = "[l]eft" })
    vim.keymap.set("n", "<leader>bcr", "<cmd>BufferLineCloseRight<cr>", { desc = "[r]ight" })
  end,
}
