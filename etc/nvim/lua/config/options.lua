-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

opt.relativenumber = false
opt.wrap = true
opt.scrolloff = 3
opt.sidescrolloff = 3
opt.cursorcolumn = true
opt.showmode = true
opt.showcmd = true
opt.list = true
opt.listchars = { tab = "> ", trail = "•", extends = "#", nbsp = "." }
