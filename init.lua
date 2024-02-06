-- Consider adding remembering last position when opening a file:
-- https://github.com/neovim/neovim/issues/16339
--

vim.opt.relativenumber = true
vim.g.lua_snippets_path = vim.fn.stdpath("config") .. "/lua/custom/snippets"


-- Fix Netrw copy doesn't work on OSX
-- https://stackoverflow.com/questions/31811335/copying-files-with-vims-netrw-on-mac-os-x-is-broken
vim.g.netrw_liststyle = 1
vim.g.netrw_preview = 1
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 80
-- vim.g.netrw_keepdir = 0

local autocmd = vim.api.nvim_create_autocmd

-- Cleanup whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    -- pcall catches errors
    pcall(function() vim.cmd [[%s/\s\+$//e]] end)
    vim.fn.setpos(".", save_cursor)
  end,
})

-- fix 'gq' set formatexpr=
-- https://vi.stackexchange.com/questions/39200/wrapping-comment-in-visual-mode-not-working-with-gq

-- Should prevent comments on newlines but is not working.
-- Actually it is kind of nice and use C-w to delete word in insert mode to remove if needed.
-- vim.opt_local.formatoptions:remove({ 'r', 'o' })
-- autocmd("User", {
--   pattern = "VeryLazy",
--   callback = function(args)
--     vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
--   end
-- })

autocmd("BufRead", {
  pattern = "*",
  callback = function(args)
    vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
  end
})

-- autocmd("BufNewFile", {
--   pattern = "conjure-log-*.cljc",
--   callback = function(args)
--     -- Might need to be called with buffer argument.
--     vim.diagnostic.disable(args.buf)
--   end
-- })
--
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.02
  vim.g.neovide_cursor_trail_size = 0.4
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_length = 0.2

  -- Allow clipboard copy paste in neovim
  vim.g.neovide_input_use_logo = 1
  vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})
end
