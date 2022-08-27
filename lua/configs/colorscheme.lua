local ok, theme = pcall(require, "catppuccin")
if not ok then
	error("Can't load coloscheme")
	return
end

-- flavours options: latte, frappe, macchiato, mocha
vim.g.catppuccin_flavour = "mocha"

theme.setup({
	term_colors = true,
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {"italic"},
		keywords = {"italic"},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {"bold"},
		operators = {},
	},
	interactions = {
		treesitter = true,
		cmp = true,
		nvimtree = true,
		indent_blankline = {
			enabled = true,
			colored_indent_level = false
		}
	},
	color_overrides = {},
	highlight_overrides = {}
})
vim.cmd [[colorscheme catppuccin]]
