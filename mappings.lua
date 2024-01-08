local M = {}

vim.g.maplocalleader = ","

local function grep_current_word()
  print("column", vim.g.colorcolumn)
  local word = vim.fn.expand("<cword>")
  require("telescope.builtin").grep_string({ search = word})
end

local function grep_current_WORD()
  local word = vim.fn.expand("<cWORD>")
  require("telescope.builtin").grep_string({ search = word})
end

local function toggle_color_column()
  if vim.api.nvim_get_option_value("colorcolumn", {}) == "" then
    vim.api.nvim_set_option_value("colorcolumn", "80", {})
  else
    vim.api.nvim_set_option_value("colorcolumn", "", {})
  end
end

M.disabled = {
  n = {
    ["<leader>b"] = "",
    ["<C-n>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    ["<tab>"] = "",
    ["<S-tab>"] = "",
  }
}

M.abc = {
  n = {
    ["gs"] = { function() require("luasnip.loaders").edit_snippet_files() end, "Goto Snippet file"},
    ["[b"] = {"<cmd>bprev<CR>", "Prev Buffer"},
    ["]b"] = {"<cmd>bnext<CR>", "Next Buffer"},
    ["[e"] = {vim.diagnostic.goto_prev, "Prev Error"},
    ["]e"] = {vim.diagnostic.goto_next, "Next Error"},
    ["[w"] = {vim.cmd.tabprev, "Prev Tab"},
    ["]w"] = {vim.cmd.tabnext, "Next Tab"},
    ["<leader>x"] = {"<cmd>Telescope live_grep<CR>", "Grep"},
    ["<leader>d"] = {"<cmd>Explore<CR>", "Open Directory"},
    ["<leader><tab>n"] = {vim.cmd.tabnew, "New Tab"},
    ["<leader><tab>d"] = {vim.cmd.tabclose, "Quit Tab"},
    ["<leader>wd"] = {vim.cmd.quit, "Window Quit"},
    ["<leader>wq"] = {vim.cmd.quit, "Window Quit"},
    ["<leader>wb"] = {vim.cmd.split, "Window Split Horizontally"},
    ["<leader>wv"] = {vim.cmd.vsplit, "Window Split Vertically"},
    ["<leader>n"] = {"<cmd>NvimTreeToggle<CR>", "NvimTree Toggle"},
    ["<leader> "] = { "<cmd>Telescope find_files<CR>", "Find files" },
    ["<leader>bb"] = { "<cmd>Telescope buffers<CR>", "Find buffers" },
    ["<leader>bd"] = { "<cmd>bdelete<CR>", "Buffer Delete" },
    ["<leader>bD"] = { "<cmd>bdelete!<CR>", "Buffer Delete!" },
    ["<leader>bm"] = { "<cmd>messages<CR>", "Messages" },
    ["<leader>cr"] = { "<cmd> Telescope lsp_references <CR>", "Code References" },
    ["<leader>cR"] = { function() require("nvchad.renamer").open() end, "LSP rename" },
    ["<leader>fr"] = { "<cmd> Telescope oldfiles <CR>", "Find Recent Files" },
    ["<leader>fw"] = { grep_current_word, "Find Word at Point" },
    ["<leader>fW"] = { grep_current_WORD, "Find WORD at Point" },
    ["<leader>fs"] = { vim.cmd.write, "Save File" },
    ["<leader>hk"] = { "<cmd>Telescope keymaps<CR>", "Help Keybindings" },
    ["<leader>ht"] = { "<cmd>TSHighlightCapturesUnderCursor<CR>", "Help Treesitter" },
    ["<leader>hT"] = { "<cmd>TSPlaygroundToggle<CR>", "Help Treesitter Playground" },
    ["<leader>tc"] = { toggle_color_column, "Toggle Color Column" },
    ["<leader>w<C-o>"] = { vim.cmd.only, "Close other windows" },
  },

  c = {
    ["<C-a>"] = {"<Home>"},
    ["<C-e>"] = {"<End>"},
    ["<C-p>"] = {"<Up>"},
    ["<C-n>"] = {"<Down>"},
    ["<C-b>"] = {"<Left>"},
    ["<C-f>"] = {"<Right>"},
    ["<M-b>"] = {"<S-Left>"},
    ["<M-f>"] = {"<S-Right>"},
  }
}

return M
