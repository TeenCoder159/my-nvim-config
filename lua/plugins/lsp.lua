return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",        -- Python LSP
          "rust_analyzer",
          "html",
          "cssls",-- Rust LSP
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Optional: Setup completion capabilities if using nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities()
      end

      -- Optional: on_attach for keymaps, etc.
      local on_attach = function(client, bufnr)
        -- Example keymap
        local bufmap = function(mode, lhs, rhs)
          vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
        end

        bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
        bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
      end

      -- Python
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- Rust
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = true,
          },
        },
      })
    end,
  },
}
