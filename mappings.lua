local M = {}

-- -- In order to disable a default keymap, use
M.disabled = {
  n = {
      ["<leader>b"] = "",
      -- ["<C-a>"] = ""
  }
}

M.abc = {
  n = {
    ["[b"] = {"<cmd>bprev<CR>", "Previous Buffer"},
    ["]b"] = {"<cmd>bnext<CR>", "Next Buffer"},
    ["<leader>n"] = {"<cmd>NvimTreeToggle<CR>", "Toggle Nvim Tree"},
    ["<leader> "] = { "<cmd>Telescope find_files<CR>", "Find files" },
    ["<leader>bb"] = { "<cmd>Telescope buffers<CR>", "Find buffers" },
    ["<leader>bd"] = { "<cmd>bdelete<CR>", "Delete current buffer" },
    ["<C-n>"] = {"<cmd>Telescope<CR>", "Telescope"},
    ["<C-s>"] = {":Telescope Files<CR>", "Telescope Files"}
  },
}

-- vim.g.maplocalleader = ","

return M
