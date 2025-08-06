vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")

require("config.lazy")

-- require("kanagawa").setup({
--     transparent = true,
-- })
-- vim.cmd("colorscheme kanagawa")

vim.cmd("colorscheme gruvbox")

vim.opt.number = true
vim.opt.clipboard = "unnamedplus"

require("config.keymaps")

-- Show ASCII art banner, then open file tree
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() == 0 then
            vim.cmd("enew")

            local lines = {
                "██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗",
                "██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝",
                "██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗  ",
                "██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝  ",
                "╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗",
                " ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝",
                "██╗   ██╗███╗   ███╗ █████╗ ███╗   ██╗ ██████╗ ██╗            ",
                "██║   ██║████╗ ████║██╔══██╗████╗  ██║██╔════╝ ██║            ",
                "██║   ██║██╔████╔██║███████║██╔██╗ ██║██║  ███╗██║            ",
                "██║   ██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║   ██║╚═╝            ",
                "╚██████╔╝██║ ╚═╝ ██║██║  ██║██║ ╚████║╚██████╔╝██╗            ",
                " ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝            ",
            }

            local colors = {
                "#89DCEB", "#7ACFE0", "#4FAACD", "#4198BB", "#347CA0",
                "#347CA0", "#89DCEB", "#7ACFE0", "#4FAACD", "#4198BB",
                "#347CA0", "#347CA0",
            }

            for i, color in ipairs(colors) do
                vim.api.nvim_set_hl(0, "BannerLine" .. i, { fg = color })
            end

            vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

            for i = 1, #lines do
                vim.api.nvim_buf_add_highlight(0, -1, "BannerLine" .. i, i - 1, 0, -1)
            end

            vim.cmd("setlocal buftype=nofile")
            vim.cmd("setlocal bufhidden=wipe")
            vim.cmd("setlocal nobuflisted")
            vim.cmd("setlocal noswapfile")

            vim.defer_fn(function()
                require("nvim-tree.api").tree.open()
            end, 500)
        end
    end,
})
