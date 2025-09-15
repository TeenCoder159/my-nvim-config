vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")

require("config.lazy")

 require("kanagawa").setup({
--     transparent = true,
 })
 vim.cmd("colorscheme kanagawa")

-- vim.cmd("colorscheme gruvbox")

vim.opt.number = true
vim.opt.clipboard = "unnamedplus"

require("config.keymaps")

