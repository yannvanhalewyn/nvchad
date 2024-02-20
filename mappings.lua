local f = require("custom.functions")

vim.g.maplocalleader = ","

local function telescope_cmd(cmd)
  return function()
    require("telescope.builtin")[cmd]()
  end
end

local M = {}

M.disabled = {
  n = {
    ["<leader>b"] = "",
    ["<C-n>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    ["<leader>h"] = "",
    ["<leader>n"] = "",
    ["<leader>v"] = "",
    ["<leader>td"] = "",
    ["<leader>gt"] = "",
    -- ["<tab>"] = "",
    -- ["<S-tab>"] = "",
  }
}

M.abc = {
  i = {
    ["<C-k>"] = {vim.lsp.buf.signature_help, "LSP: Signature Help"}
  },
  n = {
    -- Rebind increment to not use tmux prefix
    ["+"] = {"<C-a>", "Increment"},
    ["-"] = {"<C-x>", "Decrement"},
    -- ["<C-d>"] = {"<C-d>zz", "Move Down"},
    -- ["<C-u>"] = {"<C-u>zz", "Move Up"},
    ["n"] = {"nzz", "Next Search Result"},
    ["N"] = {"Nzz", "Prev Search Result"},
    ["S"] = {":%s/<C-r><C-w>/<C-r><C-w>/gI<left><left><left>", "Replace Current Word"},
    -- Somehow this disabled `<C-i>`
    -- ["<tab>"] = {"<C-a>", "Jump to matching delimiter"},
    -- ["<leader>cd"] = { function() vim.lsp.buf.hover() end, "Show doc"},
    ["<leader>tp"] = { f.toggle_parinfer, "Toggle Parinfer"},
    ["<leader>td"] = { f.toggle_diagnostics, "Toggle Diagnostics"},
    ["<leader>tD"] = { f.toggle_diagnostics_virtual_text, "Toggle Diagnostics Virtual Text"},
    ["<leader>tb"] = { function() require("gitsigns").toggle_current_line_blame() end, "Toggle LineBlame"},
    ["gs"] = { function() require("luasnip.loaders").edit_snippet_files() end, "Goto Snippet file"},
    -- ["[b"] = {"<cmd>bprev<CR>", "Prev Buffer"},
    -- ["]b"] = {"<cmd>bnext<CR>", "Next Buffer"},
    ["[e"] = {vim.diagnostic.goto_prev, "Prev Error"},
    ["]e"] = {vim.diagnostic.goto_next, "Next Error"},
    ["[q"] = {vim.cmd.cprev, "Quickfix Prev"},
    ["]q"] = {vim.cmd.cnext, "Quickfix Next"},
    -- ["[q"] = {":cp<CR>zz", "Quickfix Prev"},
    -- ["]q"] = {":cn<CR>zz", "Quickfix Next"},
    ["[w"] = {vim.cmd.tabprev, "Prev Tab"},
    ["]w"] = {vim.cmd.tabnext, "Next Tab"},
    ["<S-tab>"] = {vim.cmd.tabprev, "Prev Tab"},
    -- ["<tab>"] = {vim.cmd.tabnext, "Next Tab"},
    -- ["gr"] = { telescope_cmd("lsp_references"), "LSP References" },
    ["<leader>/"] = {telescope_cmd("current_buffer_fuzzy_find"), "Find In Current Buffer"},
    -- ["<leader>/"] = {"Telescope live_grep search_dirs={\"%:p\"} vimgrep_arguments=rg,--color=never,--no-heading,--with-filename,--line-number,--column,--smart-case,--fixed-strings", "Find in Current Buffer"},
    ["<leader>x"] = {telescope_cmd("live_grep"), "Grep"},
    ["<leader>d"] = {"<cmd>Explore %:h<CR>", "Open Directory"},
    ["<leader><tab>n"] = {vim.cmd.tabnew, "New Tab"},
    ["<leader><tab>d"] = {vim.cmd.tabclose, "Quit Tab"},
    ["<leader>wd"] = {vim.cmd.quit, "Window Quit"},
    ["<leader>wq"] = {":wall<CR>:wq<CR>", "Window Quit"},
    ["<leader>wb"] = {vim.cmd.split, "Window Split Horizontally"},
    ["<leader>wv"] = {vim.cmd.vsplit, "Window Split Vertically"},
    -- ["<leader>n"] = {"<cmd>NvimTreeToggle<CR>", "NvimTree Toggle"},
    -- ["<leader>n"] = { f.open_filetree, "Open Filetree"},
    ["<leader> "] = { telescope_cmd("find_files"), "Find files" },
    ["<leader>bb"] = { telescope_cmd("buffers"), "Find buffers" },
    -- ["<leader>bD"] = { "<cmd>bdelete!<CR>", "Buffer Delete!" },
    ["<leader>bm"] = { "<cmd>messages<CR>", "Messages" },
    ["<leader>cr"] = { telescope_cmd("lsp_references"), "Code References" },
    ["<leader>cR"] = { function() require("nvchad.renamer").open() end, "LSP rename" },
    ["<leader>ce"] = { vim.diagnostic.setqflist, "Code Diagnostics (Buffer)" },
    ["<leader>fd"] = { telescope_cmd("diagnostics"), "Find Diagnostics" },
    ["<leader>fr"] = { telescope_cmd("oldfiles"), "Find Recent Files" },
    ["<leader>fg"] = { telescope_cmd("git_files"), "Find Git Files" },
    ["<leader>fR"] = { telescope_cmd("lsp_references"), "Find References" },
    ["<leader>fo"] = { ":Telescope file_browser path=%:p:h select_buffer=true<CR>", "File Browser" },
    ["<leader>fw"] = { f.grep_current_word, "Find Word at Point" },
    ["<leader>fW"] = { f.grep_current_WORD, "Find WORD at Point" },
    ["<leader>fs"] = { vim.cmd.write, "Save File" },
    ["<leader>fS"] = { "<CMD>wall<CR>", "Save All Files" },
    ["<leader>gp"] = { function() require("gitsigns").preview_hunk_inline() end, "Git Preview hunk", },
    ["<leader>k"] = {vim.lsp.buf.signature_help, "LSP: Signature Help"},
    ["<leader>hk"] = { telescope_cmd("keymaps"), "Help Keybindings" },
    ["<leader>hh"] = { telescope_cmd("help_tags"), "Help Tags" },
    ["p"] = { ':norm "+]p<CR>', "Paste and indent" },
    ["P"] = { ':norm "+[p<CR>', "Paste and indent" },
    ["<leader>R"] = { f.refresh_chrome, "Refresh Google Chrome" },
    ["<leader>tc"] = { f.toggle_color_column, "Toggle Color Column" },
    ["<leader>tq"] = { f.toggle_quickfix_window, "Toggle Quickfix Window" },
    ["<leader>te"] = { vim.diagnostic.open_float, "Toggle Error Message" },
    ["<leader>w<C-o>"] = { vim.cmd.only, "Close other windows" },
    ["<leader>wh"] = { ":windo wincmd H<CR>", "Move Window Left" },
    ["<leader>wj"] = { ":windo wincmd J<CR>", "Move Window Right" },
    ["<leader>wk"] = { ":windo wincmd K<CR>", "Move Window Down" },
    ["<leader>wl"] = { ":windo wincmd L<CR>", "Move Window Up" },
  },

  v = {
    ["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move Selection Down"},
    ["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move Selection Up"},
    -- Actually pasting already does this in xmode so ¯\_(ツ)_/¯
    ["<leader>p"] = { '"_dP', "Paste without losing register" },
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
