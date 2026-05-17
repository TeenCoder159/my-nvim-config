local has_xcodeproj = function(path)
  return vim.fn.glob(vim.fn.fnameescape(path .. "/*.xcodeproj")) ~= ""
    or vim.fn.glob(vim.fn.fnameescape(path .. "/*.xcworkspace")) ~= ""
end

local function sourcekit_root(path)
  local markers = { "compile_commands.json", ".sourcekit-lsp", "buildServer.json", "Package.swift", ".git" }
  for _, marker in ipairs(markers) do
    if vim.fn.findfile(marker, path .. ";") ~= "" then
      return path
    end
  end
  if has_xcodeproj(path) then
    return path
  end
  return nil
end

return {
  cmd = { 'sourcekit-lsp' },
  filetypes = { 'swift', 'objective-c', 'objective-cpp' },
  root_markers = sourcekit_root,
  get_language_id = function(_, ftype)
    return ftype
  end,
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
    textDocument = {
      diagnostic = {
        dynamicRegistration = true,
        relatedDocumentSupport = true,
      },
    },
  },
  settings = {
    ["sourcekit-lsp"] = {
      backgroundIndexing = false,
    },
  },
  on_attach = function(client, bufnr)
    local bufmap = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true })
    end

    bufmap("n", "gd", vim.lsp.buf.definition)
    bufmap("n", "K", vim.lsp.buf.hover)
    bufmap("n", "gr", vim.lsp.buf.references)
    bufmap("n", "<leader>rn", vim.lsp.buf.rename)
    bufmap("n", "<leader>ca", vim.lsp.buf.code_action)

    vim.api.nvim_create_user_command("SourcekitSetupXcode", function()
      local root = vim.fn.getcwd()
      local ok = vim.fn.executable("xcode-build-server")
      if ok == 0 then
        vim.notify("Install xcode-build-server first: brew install xcode-build-server", vim.log.levels.ERROR)
        return
      end
      vim.fn.system({ "xcode-build-server", "config" })
      vim.notify("Generated buildServer.json for " .. root)
    end, {})

    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
}
