return {
  "rebelot/kanagawa.nvim",
  lazy = false,        -- add this
  priority = 1000,     -- add this
  config = function()
    require('kanagawa').setup({
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors)
        return {}
      end,
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus"
      },
    })
    vim.cmd("colorscheme kanagawa")
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.cmd [[
          highlight Normal guibg=NONE ctermbg=NONE
          highlight NormalNC guibg=NONE ctermbg=NONE
          highlight LineNr guibg=NONE ctermbg=NONE
          highlight SignColumn guibg=NONE ctermbg=NONE
          highlight VertSplit guibg=NONE ctermbg=NONE
        ]]
      end,
    })
  end
}
-- return {
--   "ellisonleao/gruvbox.nvim",
--   priority = 1000, -- (optional) ensures it loads early
--   config = function()
--     require("gruvbox").setup({
--       terminal_colors = true,
--       undercurl = true,
--       underline = true,
--       bold = true,
--       italic = {
--         strings = true,
--         emphasis = true,
--         comments = true,
--         operators = false,
--         folds = true,
--       },
--       strikethrough = true,
--       invert_selection = false,
--       invert_signs = false,
--       invert_tabline = false,
--       inverse = true,
--       contrast = "", -- "hard", "soft", or ""
--       palette_overrides = {},
--       overrides = {},
--       dim_inactive = false,
--       transparent_mode = false,
--     })
-- 
--     vim.cmd.colorscheme("gruvbox")
--   end,
-- }
