 return {
     "rebelot/kanagawa.nvim",
     config = function()
         -- Default options:
         require('kanagawa').setup({
             compile = false, -- enable compiling the colorscheme
             undercurl = true, -- enable undercurls
             commentStyle = { italic = true },
             functionStyle = {},
             keywordStyle = { italic = true },
             statementStyle = { bold = true },
             typeStyle = {},
             transparent = false, -- do not set background color
             dimInactive = false, -- dim inactive window `:h hl-NormalNC`
             terminalColors = true, -- define vim.g.terminal_color_{0,17}
             colors = {     -- add/modify theme and palette colors
                 palette = {},
                 theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
             },
             overrides = function(colors) -- add/modify highlights
                 return {}
             end,
             theme = "wave", -- Load "wave" theme
             background = { -- map the value of 'background' option to a theme
                 dark = "wave", -- try "dragon" !
                 light = "lotus"
             },
         })
 
         -- setup must be called before loading
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
