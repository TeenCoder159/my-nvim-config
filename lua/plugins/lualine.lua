return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "kanagawa",
                icons_enabled = true,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = { statusline = {}, winbar = {} },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = {
                    { "mode", icon = "" },
                },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
lualine_x = {
          "fileformat",
          "filetype",
          {
            function()
              return os.date("%H:%M:%S")
            end,

          },
        },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            extensions = {},
        })
    end,
}
