local function map(mode, lhs, rhs, opts, lsp)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

local M = {}

--NvimTree
M.nvimTree = function()
	map('n', '<C-n>', ':NvimTreeToggle<CR>')
	map('n', '<leader>e', ':NvimTreeFocus<CR>')
end

M.lspConfigOnAttach = function(bufopts)
	map('n', 'gD', ":lua vim.lsp.buf.declaration()<CR>", bufopts)
	map('n', 'gd', ":lua vim.lsp.buf.definition()<CR>", bufopts)
	map('n', 'K', ":lua vim.lsp.buf.hover()<CR>", bufopts)
	map('n', 'gi', ":lua vim.lsp.buf.implementation()<CR>", bufopts)
	map('n', '<C-k>', ":lua vim.lsp.buf.signature_help()<CR>", bufopts)
	map('n', '<leader>wa', ":lua vim.lsp.buf.add_workspace_folder()<CR>", bufopts)
	map('n', '<leader>wr', ":lua vim.lsp.buf.remove_workspace_folder()<CR>", bufopts)
	map('n', '<leader>D', ":lua vim.lsp.buf.type_definition()<CR>", bufopts)
	map('n', '<leader>rn', ":lua vim.lsp.buf.rename()<CR>", bufopts)
	map('n', '<leader>ca', ":lua vim.lsp.buf.code_action()<CR>", bufopts)
	map('n', 'gr', ":lua vim.lsp.buf.references()<CR>", bufopts)
	map('n', '<leader>f', ":lua vim.lsp.buf.format({async = true})<CR>", bufopts)
end

M.lspConfig = function()
	map('n', '<leader>e', ":lua vim.diagnostic.open_float()<CR>")
	map('n', '[d', ":lua vim.diagnostic.goto_prev()<CR>")
	map('n', ']d', ":lua vim.diagnostic.goto_next()<CR>")
	map('n', '<leader>q', ":lua vim.diagnostic.setloclist()<CR>")
end

return M
