return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "slant",
      },

      highlights = {
        -- The “background fill” behind all tabs
        fill = {
          bg = "NONE",  -- fully transparent
        },
        -- Inactive (unfocused) buffer tabs
        background = {
          bg = "NONE",  -- transparent
          -- You may set fg to a dimmer color if you want:
          -- fg = "#5c5f66",
        },
        -- Buffers that are open and visible (e.g. in another window), but not selected
        buffer_visible = {
          bg = "NONE",  -- transparent
          -- fg = "#abb2bf",
        },
        -- The currently selected (active) buffer
        buffer_selected = {
          bg = "NONE",  -- transparent for the active tab
          -- fg = "#cdd6f4",  -- optionally set a brighter fg for the active tab
          bold = true,
        },
        -- The little indicator (triangle or bar) under the selected tab
        indicator_selected = {
          bg = "NONE",     -- keep it transparent
          -- fg = "#cdd6f4", -- optionally set this to the same fg as buffer_selected
        },
        -- The separator between each tab, when tabs are inactive
        separator = {
          bg = "NONE",  -- transparent
          -- fg = "#2a2c34", -- choose a dark shade if you want a subtle line
        },
        separator_selected = {
          bg = "NONE",
          -- fg = "#2a2c34",
        },
        separator_visible = {
          bg = "NONE",
          -- fg = "#2a2c34",
        },
      },
      -- ───────────────────────────────────────────────────────────────────
    })

    -- Keymaps for stepping through buffers
    vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>")
    vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")
    vim.keymap.set("n", "<leader>bc", ":bd<cr>")
  end,
}

