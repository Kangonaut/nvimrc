-- [[ alpha.nvim ]]
-- desc: cool greeter dashboard
-- repo: https://github.com/goolord/alpha-nvim

return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- dashboard.section.buttons.val = {}

    local logo = [[



                                              
       ████ ██████           █████      ██
      ███████████             █████ 
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████
    ]]

    local builtin = require("telescope.builtin")

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.header.opts.hl = "Keyword"
    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("<leader> ff", "  find file", builtin.find_files),
      dashboard.button("<leader> fg", "  find grep", builtin.live_grep),
      dashboard.button("<leader> fr", "󰄉  recent files", builtin.oldfiles),
      dashboard.button("<leader> fGc", " find git commits", builtin.git_commits),
      dashboard.button("<leader> fm", " find man page", builtin.man_pages),
    }
    alpha.setup(dashboard.opts)
  end,
}
