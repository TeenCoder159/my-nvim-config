local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Normal mode mappings
map("n", "<leader>w", ":w<CR>", opts)


vim.g.mapleader = " "         -- <leader> is now the Space key
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
vim.keymap.set("n", "<leader>q",":q | :q<CR>", { desc = "Quit and write everything" })
vim.keymap.set("n", "sy", ":Lazy sync<CR>")

vim.keymap.set({"n", "v"}, "<leader>fy", 'ggVG"+y', { desc = "Yank file content to clipboard" })

vim.keymap.set("n", "<leader>i", function()
  local file = vim.fn.expand("%")
  local gitignore_path = ".gitignore"

  -- Ensure .gitignore is in the root directory
  if not vim.loop.fs_stat(gitignore_path) then
    vim.fn.writefile({}, gitignore_path)
  end

  local lines = vim.fn.readfile(gitignore_path)
  local found = false

  for i, line in ipairs(lines) do
    if line == file then
      table.remove(lines, i)
      found = true
      break
    end
  end

  if not found then
    table.insert(lines, file)
    print("Added " .. file .. " to .gitignore")
  else
    print("Removed " .. file .. " from .gitignore")
  end

  vim.fn.writefile(lines, gitignore_path)
end, { desc = "Toggle current file in .gitignore" })
