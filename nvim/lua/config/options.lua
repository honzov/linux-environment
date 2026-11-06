-- Loaded before lazy.nvim startup. LazyVim defaults:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
local opt = vim.opt

-- carried over from _vimrc
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.scrolloff = 8
opt.wrap = false
opt.colorcolumn = "80"
opt.swapfile = false

-- pick up changes made by other tools (e.g. Claude) automatically
opt.autoread = true

-- show relative numbers only in the focused window is LazyVim's default; keep absolute too
opt.number = true
opt.relativenumber = false

-- python LSP: "pyright" (default) or "basedpyright"
vim.g.lazyvim_python_lsp = "pyright"
