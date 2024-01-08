local autocmd = vim.api.nvim_create_autocmd

autocmd("User", {
  pattern = "VeryLazy",
  callback = function(args)
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end
})

vim.opt.relativenumber = true;
