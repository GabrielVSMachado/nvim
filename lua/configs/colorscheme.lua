local ok, module = pcall(require, 'vscode')
if not ok then
  vim.notify("Couldn't load vscode colorscheme !!!")
  return
end

vim.o.background = 'dark'

local colors = require 'vscode.colors'

module.setup({
  disable_nvimtree_bg = true,
  italic_comments = true,
  group_overrides = {
    Cursor = {
      fg = colors.vscDarkBlue,
      bg = colors.vscLightGreen,
      bold = true
    },
  }
})
