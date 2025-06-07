vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
require("config.lazy")

require("kanagawa").setup({
  transparent = true,
})
vim.cmd("colorscheme kanagawa")
vim.g.mapleader = " "         -- <leader> is now the Space key
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
vim.keymap.set("n", "<leader>q",":q | :q<CR>", { desc = "Quit and write everything" })


vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    local api = require("nvim-tree.api")
    if vim.fn.argc() == 0 then
      api.tree.open()
    end
  end,
})
vim.opt.number = true

vim.keymap.set("n", "sy", ":Lazy sync<CR>")
vim.opt.clipboard = "unnamedplus"
