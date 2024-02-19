# Example Config

This can be used as an example custom config for NvChad. Do check the https://github.com/NvChad/nvcommunity

# Checkout

- https://github.com/PaterJason/cmp-conjure

# TODO

- [x] Remove tabufline

- [ ] FIX 'gq' set formatexpr=
https://vi.stackexchange.com/questions/39200/wrapping-comment-in-visual-mode-not-working-with-gq

- [ ] Consider adding remembering last position when opening a file:
https://github.com/neovim/neovim/issues/16339

- [ ] Consider scrolling animations
Maybe using https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-animate.md and disabling all but scroll.
Or https://github.com/karb94/neoscroll.nvim but disable in neovide??

- [x] Replace vim-sexp with parpar
Vim sexp was great but seems unmaintained.

- [x] Replace 'virtual text' diagnostics with hover
```lua
---autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()
-- https://www.reddit.com/r/neovim/comments/rcg0d4/how_can_i_just_turn_off_virtual_text_from_the_lsp/
-- https://neovim.discourse.group/t/how-to-show-diagnostics-on-hover/3830/3
vim.diagnostic.config({
    virtual_text = false,
})
```

- [x] Find out who overwrites 'K'

- [ ] Markdow Preview?
https://github.com/iamcco/markdown-preview.nvim

- Maybe check out: LSP file operations: https://github.com/antosha417/nvim-lsp-file-operations

# New bindings

| Binding   | Command        |
|-----------|----------------|
| gt        | Todo Quickfix  |
| gT        | Todo Trouble   |
| Leader ft | Todo Telescope |
| Leader ft | Todo Telescope |
| Leader tt | Toggle Trouble |
| Leader td | Trouble Diagnostics (Doc) |
| Leader tD | Trouble Diagnostics (Project) |
| Leader tq | Trouble Quickfix |
| Leader tl | Trouble LocList |
| Leader tr | Trouble References |
