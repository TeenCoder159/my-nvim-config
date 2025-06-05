-- lua/terminal.lua
return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      direction = "horizontal",
      -- Set terminal size based on window dimensions
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        else
          return math.floor(vim.o.lines * 0.8)
        end
      end,
      open_mapping = [[<C-j>]], -- Shortcut to toggle the terminal
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        winblend = 3,
      },
    })
    -- Create a normal-mode key mapping to toggle the terminal
    vim.keymap.set("n", "<C-j>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
  end,
}

