local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		-- latest stable release lazypath
		"--branch=stable",
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.termguicolors = true

require("lazy").setup("plugins")

-- Move around windows with vim keys
vim.api.nvim_set_keymap("n", "<leader>h", ":wincmd h<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>j", ":wincmd j<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", ":wincmd k<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>l", ":wincmd l<CR>", { noremap = true, silent = true })

-- Colorscheme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

-- Zoom in and make the "o"nly window
vim.keymap.set("n", "<leader>O", ":tab split<CR>", { noremap = true, silent = true })

-- Enable syntax highlighting
-- vim.cmd('syntax on')

-- Set spell checking
vim.opt.spell = true

-- Disable error bells
vim.opt.errorbells = false

-- Set tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable smart indentation
vim.opt.smartindent = true

-- Show line numbers
vim.opt.number = true

-- Disable line wrapping
vim.opt.wrap = false

-- Enable smart case sensitivity in searches
vim.opt.smartcase = true

-- Disable swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false

-- Configure undo
-- vim.opt.undodir = '~/.vim/undodir'
-- vim.opt.undofile = true

-- Enable incremental search
vim.opt.incsearch = true

-- Set scroll offset
vim.opt.scrolloff = 15

-- Set relative line numbers
vim.opt.relativenumber = true

-- Set encoding
vim.opt.encoding = "utf-8"

-- Configure backspace behavior
vim.opt.backspace:remove("indent")
vim.opt.backspace:append({ "indent", "eol", "start" })

-- Copy and paste to system clipboard
vim.api.nvim_set_keymap("v", "<leader>y", '"*y', { noremap = true })
vim.opt.clipboard = "unnamedplus"

-- Set color column
-- vim.opt.colorcolumn = '88'
-- vim.cmd('highlight ColorColumn ctermbg=0 guibg=grey')
--

-- Terminal mode escape key
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

vim.g.markdown_fenced_languages = { "python", "bash=sh", "yaml", "json", "vim", "lua" }
