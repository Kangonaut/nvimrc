-- [[ image.nvim ]]
-- desc: add image support to Neovim
-- repo: https://github.com/3rd/image.nvim

-- configuring Neovim to load user-installed Lua rocks without the `luarocks.nvim` plugin
-- package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/magick/init.lua"

return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "3rd/image.nvim",
    -- init = function()
    --   package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
    --   package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
    -- end,
    dependencies = { "luarocks.nvim" },
    opts = {
      backend = "kitty",

      -- NOTE: this is up to personal preference
      max_width = 100, -- default: 100
      max_height = 12, -- default: 12

      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,

      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
}
