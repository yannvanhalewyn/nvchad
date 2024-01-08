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
    ["[b"] = {"<cmd>bprev<CR>", "Prev Buffer"},
    ["]b"] = {"<cmd>bnext<CR>", "Next Buffer"},
    ["[e"] = {vim.diagnostic.goto_prev, "Prev Error"},
    ["]e"] = {vim.diagnostic.goto_next, "Next Error"},
    ["[w"] = {vim.cmd.tabprev, "Prev Tab"},
    ["]w"] = {vim.cmd.tabnext, "Next Tab"},
    ["<leader>wn"] = {vim.cmd.tabnew, "New Tab"},
    ["<leader>wd"] = {vim.cmd.quit, "Quit window"},
    ["<leader>n"] = {"<cmd>NvimTreeToggle<CR>", "Toggle Nvim Tree"},
    ["<leader> "] = { "<cmd>Telescope find_files<CR>", "Find files" },
    ["<leader>bb"] = { "<cmd>Telescope buffers<CR>", "Find buffers" },
    ["<leader>bd"] = { "<cmd>bdelete<CR>", "Delete current buffer" },
    ["<leader>cr"] = { "<cmd> Telescope lsp_references <CR>", "[C]ode [R]references" },
    ["<leader>fr"] = { "<cmd> Telescope oldfiles <CR>", "[F]ind [R]ecent files" },
  },
}

vim.opt.relativenumber = true;
vim.g.maplocalleader = ","

return M
