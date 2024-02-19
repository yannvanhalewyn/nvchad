-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
  },
  ["@function"] = {
    fg = "yellow",
  },
  ["@function.call"] = {
    fg = "yellow",
  },
  -- ["@constructor"] = {
  --   fg = "yellow",
  -- },

  ["@string.special"] = {
    fg = "blue",
  },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

-- Looks at DiffDelete and DiffAdd colors. However they seem to be getting overwritten
vim.cmd("highlight NeogitDiffDelete guifg='#e06c75' guibg='#431a1e'")
vim.cmd("highlight NeogitDiffDeleteHighlight guifg='#e06c75' guibg='#511c21'")
vim.cmd("highlight TabLineFill guifg=#2d3139 guibg=black" )
vim.cmd("highlight TabLine guifg=#6f737b guibg=#2d3139")

-- From https://vi.stackexchange.com/questions/10897/how-do-i-customize-vimdiff-colors
-- but getting overwritten somehow.
-- vim.cmd("hi DiffAdd      gui=none    guifg=NONE          guibg=#bada9f")
-- vim.cmd("hi DiffChange   gui=none    guifg=NONE          guibg=#e5d5ac")
-- vim.cmd("hi DiffDelete   gui=bold    guifg=#ff8080       guibg=#ffb0b0")
-- vim.cmd("hi DiffText     gui=none    guifg=NONE          guibg=#8cbee2")

return M

-- local theme = require("base46.themes." .. vim.g.nvchad_theme)
-- {
--   base00 = "#1e222a",
--   base01 = "#353b45",
--   base02 = "#3e4451",
--   base03 = "#545862",
--   base04 = "#565c64",
--   base05 = "#abb2bf",
--   base06 = "#b6bdca",
--   base07 = "#c8ccd4",
--   base08 = "#e06c75",
--   base09 = "#d19a66",
--   base0A = "#e5c07b",
--   base0B = "#98c379",
--   base0C = "#56b6c2",
--   base0D = "#61afef",
--   base0E = "#c678dd",
--   base0F = "#be5046"
-- }
