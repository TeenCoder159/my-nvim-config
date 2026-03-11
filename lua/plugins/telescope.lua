-- plugins/telescope.lua
return {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.1', -- or branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', "<C-p>", builtin.git_files, { desc = 'Telescope find files' })
	vim.keymap.set('n', "<leader>ps", function()
		builtin.grep_string({ search = vim.fn.input("Grep > ")})
	end)
    end,
}

