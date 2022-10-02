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
  map('n', '<leader>a', ':NvimTreeFocus<CR>')
  map('n', '<C-n>', ':NvimTreeToggle<CR>')
end

M.lspConfigOnAttach = function(bufopts)
  map('n', 'gD', ":lua vim.lsp.buf.declaration()<CR>", bufopts)
  map('n', 'gd', ":lua vim.lsp.buf.definition()<CR>", bufopts)
  map('n', 'K', ":lua vim.lsp.buf.hover()<CR>", bufopts)
  map('n', 'gi', ":lua vim.lsp.buf.implementation()<CR>", bufopts)
  map('n', '<C-s>', ":lua vim.lsp.buf.signature_help()<CR>", bufopts)
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

M.telescope = function()
  map('n', '<leader>ff', ':Telescope find_files<CR>')
  map('n', '<leader>fg', ':Telescope live_grep<CR>')
  map('n', '<leader>fb', 'Telescope buffers<CR>')
  map('t', '<Esc>', '<C-\\><C-n>')
  map('n', '<F12>', ':Stdheader<CR>')
  map('n', '<leader>fh', ':Telescope help_tags<CR>')
end

M.utils = function()

  -- Move between windows
  map('n', '<C-h>', '<C-w>h')
  map('n', '<C-j>', '<C-w>j')
  map('n', '<C-k>', '<C-w>k')
  map('n', '<C-l>', '<C-w>l')

  -- Selection helper
  map('v', '>', '>gv')
  map('v', '<', '<gv')

  -- Move between lines
  map('v', '<A-j>', ':m .+1<CR>==gv')
  map('v', '<A-k>', ':m .-2<CR>==gv')
  map('x', '<A-j>', ":move '>+1<CR>gv-gv")
  map('x', '<A-k>', ":move '<-2<CR>gv-gv")
end

return M
