local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end


local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}


local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', "v:lua.vim.lsp.omnifunc")
	require "core.mappings".lspConfigOnAttach({ buffer = bufnr })
end

lspconfig.clangd.setup {
	on_attach = on_attach,
	capabilities = capabilities
}
