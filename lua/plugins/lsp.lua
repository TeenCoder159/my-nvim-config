return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },

{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.config").setup({
      ensure_installed = {
        "go",
        "gomod",
        "lua",
        "zig",
        "gleam",
        "javascript",
        "typescript",
        "tsx",
      },
      highlight = { enable = true },
    })
  end,
},

  {
     "williamboman/mason-lspconfig.nvim",
     dependencies = { "williamboman/mason.nvim" },
     config = function()
       require("mason-lspconfig").setup({
         ensure_installed = {
           "pyright",
           "rust_analyzer",
           "html",
           "tailwindcss",
           "gopls",
           "zls",
           "ts_ls",
         },
         automatic_installation = true,
       })
     end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      -- diagnostics
      vim.diagnostic.config({
        virtual_text = {
          spacing = 2,
          prefix = "●",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- inlay hints: disable for ltex, enable for others
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if client.name == "ltex" or client.name == "ltex_ls" then
            vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
          else
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end
        end,
      })

      -- base capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- generic on_attach
      local on_attach = function(_, bufnr)
        local bufmap = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true })
        end
        bufmap("n", "gd", vim.lsp.buf.definition)
        bufmap("n", "K", vim.lsp.buf.hover)
      end

      ----------------------------------------------------------------------
      -- Python (pyright + optional ruff)
      ----------------------------------------------------------------------
      local function python_on_attach(client, bufnr)
        local bufmap = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true })
        end
        bufmap("n", "gd", vim.lsp.buf.definition)
        bufmap("n", "K", vim.lsp.buf.hover)
        bufmap("n", "gr",vim.lsp.buf.references)
        bufmap("n", "<leader>rn", vim.lsp.buf.rename)
        bufmap("n", "<leader>ca", vim.lsp.buf.code_action)

        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end

      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        capabilities = capabilities,
        on_attach = python_on_attach,
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
        settings = {
          python = {
            analysis = {
              autoImportCompletions = true,
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
            },
          },
        },
      })

      ----------------------------------------------------------------------
      -- Rust
      ----------------------------------------------------------------------
      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            rustfmt = {
              overrideCommand = { "dx", "fmt", "--all-code", "-f", "-" },
            },
            cargo = { allFeatures = true },
            checkOnSave = true,
	    procMacro = {
		ignored = {
		  leptos_macro = {
		    -- optional: --
		    -- "component",
		    "server",
		  },
		},
	      },
          },
        },
      })

      ----------------------------------------------------------------------
      -- Go
      ----------------------------------------------------------------------
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          },
        },
      })

      ----------------------------------------------------------------------
      -- Zig
      ----------------------------------------------------------------------
      vim.lsp.config("zls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      ----------------------------------------------------------------------
      -- TypeScript / JavaScript
      ----------------------------------------------------------------------
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      ----------------------------------------------------------------------
      -- Gleam
      ----------------------------------------------------------------------
	local lspconfig = require("lspconfig")
	local configs = require("lspconfig.configs")

	-- Only define the server if lspconfig doesn't already have it
	if not configs.gleam then
	  configs.gleam = {
	    default_config = {
	      cmd = { "gleam", "lsp" },
	      filetypes = { "gleam" },
	      root_dir = lspconfig.util.root_pattern("gleam.toml", ".git"),
	      single_file_support = true,
	    },
	  }
	end

	lspconfig.gleam.setup({
	  capabilities = capabilities,
	  on_attach = on_attach,
	})
    end,
  },
}
