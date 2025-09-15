return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      color = {
        suggestion_color = "#928374",
        cterm = 244,
      },
      log_level = "info", -- set to "off" to disable logging completely
    })
  end,
}
