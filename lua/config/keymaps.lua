local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Normal mode mappings
map("n", "<leader>w", ":w<CR>", opts)


vim.g.mapleader = " "         -- <leader> is now the Space key
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
vim.keymap.set("n", "<leader>q",":q | :q<CR>", { desc = "Quit and write everything" })
vim.keymap.set("n", "sy", ":Lazy sync<CR>")

vim.keymap.set({"n", "v"}, "<leader>fy", 'ggVG"+y', { desc = "Yank file content to clipboard" })
