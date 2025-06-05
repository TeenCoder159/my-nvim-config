return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      git = {
        enable = true,
        ignore = false,
      },
      view = {
          width = 50,
          side = "right",
        },
      filters = {
        dotfiles = false,
        custom = { "^\\.git$" },
      },
    })
  end,
}
