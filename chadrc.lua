---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
  theme = "onedark",
  theme_toggle = { "onedark", "one_light" },
  transparency = false,

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    overriden_modules = function(modules)
      -- https://github.com/NvChad/ui/blob/v2.0/lua/nvchad/statusline/default.lua
      local icon = " 󰈚 "
      local path = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(vim.g.statusline_winid))
      local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")

      if name ~= "Empty " then
        local devicons_present, devicons = pcall(require, "nvim-web-devicons")

        if devicons_present then
          local ft_icon = devicons.get_icon(name)
          icon = (ft_icon ~= nil and " " .. ft_icon) or icon
        end

        name = " " .. name .. " "
      end

      -- % -> current file
      -- :~ -> prevent tilde expansion
      -- :. -> make it relative to current dir.
      local relative_path = vim.fn.expand('%:~:.')
      local path_info = "%#St_file_info#" .. icon .. relative_path .. "%#St_file_sep#" .. ""
      modules[2] = path_info
    end
  },

  tabufline = {
    enabled = false
  },

  -- nvdash = {
  --   load_on_startup = true
  -- }
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

-- Enable netrw as ChadNV disables it by default
M.lazy_nvim = {
  performance = {
    rtp = {
      disabled_plugins = vim.tbl_filter(function(name)
        return string.sub(name, 1, 5) ~= "netrw"
      end, require("plugins.configs.lazy_nvim").performance.rtp.disabled_plugins),
    },
  },
}

return M
