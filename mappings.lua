vim.g.maplocalleader = ","

local function telescope_cmd(cmd)
  return function()
    require("telescope.builtin")[cmd]()
  end
end

local function grep_current_word()
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

local function toggle_quickfix_window()
  local qf_exists = false

  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end

  if qf_exists then
    vim.cmd.cclose()
  elseif not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd.copen()
  end
end

local function toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.lsp.diagnostic.clear(0)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
  else
    vim.g.diagnostics_active = true
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      }
    )
  end
end

local function refresh_chrome()
  -- Append '& active' to activate Chrome
  local script = 'tell application "Google Chrome" to (reload (active tab of (window 1)))'
  local cmd = string.format("osascript -e '%s' 2>&1", script)
  local res = os.execute(cmd)
end

local function pause_parinfer()
  if vim.b.parinfer_enabled then
    local prev_mode = vim.g.parinfer_mode
    vim.b.parinfer_enabled = false
    print("Parinfer Paused")
    return function()
      vim.g.parinfer_mode = "paren"
      vim.b.parinfer_enabled = true
      -- "parinfer.setup" exposes parinfer global
      --- @diagnostic disable-next-line: undefined-global
      parinfer.text_changed(vim.fn.bufnr())
      vim.g.parinfer_mode = prev_mode
      print("Parinfer Resumed")
    end
  else
    return function() end
  end
end

local resume_parinfer = nil

local function toggle_parinfer()
  if resume_parinfer then
    resume_parinfer()
    resume_parinfer = nil
  else
    resume_parinfer = pause_parinfer()
  end
end

local function open_filetree()
  local prev_size = vim.g.netrw_winsize
  vim.g.netrw_winsize = -30
  vim.cmd("Lexplore")
  vim.g.netrw_winsize = prev_size
end

local M = {}

M.disabled = {
  n = {
    ["<leader>b"] = "",
    ["<C-n>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    ["<leader>td"] = "",
    ["<tab>"] = "",
    ["<S-tab>"] = "",
  }
}

M.abc = {
  n = {
    ["<leader>cd"] = { function() vim.lsp.buf.hover() end, "Show doc"},
    ["<leader>tp"] = { toggle_parinfer, "Toggle Parinfer"},
    ["gs"] = { function() require("luasnip.loaders").edit_snippet_files() end, "Goto Snippet file"},
    ["[b"] = {"<cmd>bprev<CR>", "Prev Buffer"},
    ["]b"] = {"<cmd>bnext<CR>", "Next Buffer"},
    ["[e"] = {vim.diagnostic.goto_prev, "Prev Error"},
    ["]e"] = {vim.diagnostic.goto_next, "Next Error"},
    ["[q"] = {vim.cmd.cprev, "Quickfix Prev"},
    ["]q"] = {vim.cmd.cnext, "Quickfix Next"},
    ["[w"] = {vim.cmd.tabprev, "Prev Tab"},
    ["]w"] = {vim.cmd.tabnext, "Next Tab"},
    -- ["gr"] = { telescope_cmd("lsp_references"), "LSP References" },
    ["<leader>/"] = {telescope_cmd("current_buffer_fuzzy_find"), "Find In Current Buffer"},
    ["<leader>x"] = {telescope_cmd("live_grep"), "Grep"},
    ["<leader>d"] = {"<cmd>Explore %:h<CR>", "Open Directory"},
    ["<leader><tab>n"] = {vim.cmd.tabnew, "New Tab"},
    ["<leader><tab>d"] = {vim.cmd.tabclose, "Quit Tab"},
    ["<leader>wd"] = {vim.cmd.quit, "Window Quit"},
    ["<leader>wq"] = {vim.cmd.quit, "Window Quit"},
    ["<leader>wb"] = {vim.cmd.split, "Window Split Horizontally"},
    ["<leader>wv"] = {vim.cmd.vsplit, "Window Split Vertically"},
    -- ["<leader>n"] = {"<cmd>NvimTreeToggle<CR>", "NvimTree Toggle"},
    ["<leader>n"] = { open_filetree, "Open Filetree"},
    ["<leader> "] = { telescope_cmd("find_files"), "Find files" },
    ["<leader>bb"] = { telescope_cmd("buffers"), "Find buffers" },
    ["<leader>bd"] = { "<cmd>BD<CR>", "Buffer Delete" }, -- Uses buffkill
    ["<leader>bD"] = { "<cmd>bdelete!<CR>", "Buffer Delete!" },
    ["<leader>bm"] = { "<cmd>messages<CR>", "Messages" },
    ["<leader>cr"] = { telescope_cmd("lsp_references"), "Code References" },
    ["<leader>cR"] = { function() require("nvchad.renamer").open() end, "LSP rename" },
    ["<leader>fd"] = { telescope_cmd("diagnostics"), "Find Diagnostics" },
    ["<leader>fr"] = { telescope_cmd("oldfiles"), "Find Recent Files" },
    ["<leader>fw"] = { grep_current_word, "Find Word at Point" },
    ["<leader>fW"] = { grep_current_WORD, "Find WORD at Point" },
    ["<leader>fs"] = { vim.cmd.write, "Save File" },
    ["<leader>hk"] = { telescope_cmd("keymaps"), "Help Keybindings" },
    ["<leader>hh"] = { telescope_cmd("help_tags"), "Help Tags" },
    ["<leader>R"] = { refresh_chrome, "Refresh Google Chrome" },
    ["<leader>tc"] = { toggle_color_column, "Toggle Color Column" },
    -- ["<leader>tq"] = { toggle_quickfix_window, "Toggle Quickfix Window" },
    ["<leader>te"] = { vim.diagnostic.open_float, "Toggle Error Message" },
    ["<leader>w<C-o>"] = { vim.cmd.only, "Close other windows" },
    ["<leader>wh"] = { ":windo wincmd H<CR>", "Move Window Left" },
    ["<leader>wj"] = { ":windo wincmd J<CR>", "Move Window Right" },
    ["<leader>wk"] = { ":windo wincmd K<CR>", "Move Window Down" },
    ["<leader>wl"] = { ":windo wincmd L<CR>", "Move Window Up" },
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
