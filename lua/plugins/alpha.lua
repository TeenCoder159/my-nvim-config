return {

  { "folke/snacks.nvim", opts = { dashboard = { enabled = false } } },
  -- Dashboard. This runs when neovim starts, and is what displays
  -- the "LAZYVIM" banner.
{
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  init = false,
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗
██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝
██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗  
██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝  
╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗
 ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝
██╗   ██╗███╗   ███╗ █████╗ ███╗   ██╗ ██████╗ ██╗            
██║   ██║████╗ ████║██╔══██╗████╗  ██║██╔════╝ ██║            
██║   ██║██╔████╔██║███████║██╔██╗ ██║██║  ███╗██║            
██║   ██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║   ██║╚═╝            
╚██████╔╝██║ ╚═╝ ██║██║  ██║██║ ╚████║╚██████╔╝██╗            
 ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝            
    ]]

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file",       "<cmd>Telescope find_files <cr>"),
      dashboard.button("n", "  New file", "<cmd>Oil<cr>"),
      dashboard.button("g", " " .. " LazyGit", "<cmd> LazyGit <CR>"),
      dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
      dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 8

    -- return dashboard *with* on_highlights override
    return {
      layout = dashboard.layout,
      section = dashboard.section,
      opts = dashboard.opts,
      on_highlights = function(highlights, colors)
        highlights.AlphaHeader = { fg = "#b8bb26" }  -- Gruvbox green
      end,
    }
  end,
config = function(_, dashboard)
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "AlphaReady",
      callback = function()
        require("lazy").show()
      end,
    })
  end

  require("alpha").setup(dashboard.opts)

  -- Force set highlight after setup
  vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#b8bb26" }) -- Gruvbox green

  vim.api.nvim_create_autocmd("User", {
    once = true,
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = "⚡ Neovim loaded "
        .. stats.loaded
        .. "/"
        .. stats.count
        .. " plugins in "
        .. ms
        .. "ms"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
  end
}
}
