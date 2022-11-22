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
  map('n', '<leader>fb', ':Telescope buffers<CR>')
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
  -- <A-j> ==> ʝ in macos
  -- <A-k> ==> ĸ in macos
  map('v', 'ʝ', ':m .+1<CR>==gv')
  map('v', 'ĸ', ':m .-2<CR>==gv')
  map('x', 'ʝ', ":move '>+1<CR>gv-gv")
  map('x', 'ĸ', ":move '<-2<CR>gv-gv")
end

M.gitsigns = function(bufnr)
  local gs = package.loaded.gitsigns
  local options = { buffer = bufnr, expr = true }

  map('n', ']c', function()
    if vim.wo.diff then return end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, options)

  map('n', '[c', function()
    if vim.wo.diff then return end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, options)

  map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
  map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
  map('n', '<leader>hS', gs.stage_buffer)
  map('n', '<leader>hu', gs.undo_stage_hunk)
  map('n', '<leader>hR', gs.reset_buffer)
  map('n', '<leader>hp', gs.preview_hunk)
  map('n', '<leader>hb', function() gs.blame_line { full = true } end)
  map('n', '<leader>tb', gs.toggle_current_line_blame)
  map('n', '<leader>hd', gs.diffthis)
  map('n', '<leader>hD', function() gs.diffthis('~') end)
  map('n', '<leader>td', gs.toggle_deleted)

  -- Text object
  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

return M
