-- [[ telescope.nvim ]]
-- desc: fuzzy finder
-- repo: https://github.com/nvim-telescope/telescope.nvim

return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = "make",

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")

    -- [[ configure keymaps ]]
    -- neovim
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[h]elp" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[k]eymaps" })
    vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[s]electors (telescope)" })
    vim.keymap.set("n", "<leader>fC", builtin.commands, { desc = "[c]ommands" })
    vim.keymap.set("n", "<leader>fn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[n]eovim files" })

    -- git
    vim.keymap.set("n", "<leader>fGc", builtin.git_commits, { desc = "[c]ommits" })
    vim.keymap.set("n", "<leader>fGs", builtin.git_status, { desc = "[s]tatus" })

    -- linux
    vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "[m]an page" })

    -- files & buffers
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[f]iles" })
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[w]ord under cursor (root dir)" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[g]rep (root dir)" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[d]iagnostics" })
    vim.keymap.set("n", "<leader>fR", builtin.resume, { desc = "[R]esume" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[r]ecent files" })
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      { desc = "[b]uffers" })
    vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, { desc = "[c]urrent buffer contents" })

    -- visual selection
    vim.keymap.set("v", "<leader>fs", builtin.grep_string, { desc = "[s]election" })
  end,
}
