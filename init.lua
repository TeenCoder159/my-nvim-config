vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
require("config.lazy")

require("kanagawa").setup({
  transparent = true,
})
vim.cmd("colorscheme kanagawa")


vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    local api = require("nvim-tree.api")
    if vim.fn.argc() == 0 then
      api.tree.open()
    end
  end,
})
vim.opt.number = true

vim.opt.clipboard = "unnamedplus"
require("config.keymaps")
