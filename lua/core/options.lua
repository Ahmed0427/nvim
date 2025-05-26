vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.linebreak = true
vim.o.autoindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.splitbelow = true
vim.o.splitright = true
vim.opt.termguicolors = true
vim.o.whichwrap = 'bs<>[]hl'
vim.o.numberwidth = 4
vim.o.swapfile = false
vim.o.pumheight = 10
vim.wo.signcolumn = 'yes'
vim.o.breakindent = true
vim.o.updatetime = 250
vim.o.timeoutlen = 500
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.completeopt = 'menuone,noselect'
vim.opt.shortmess:append('c')
vim.opt.iskeyword:append('-')
vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
vim.g.netrw_banner = 0
vim.o.fillchars = "eob: "
vim.opt.showtabline = 0
