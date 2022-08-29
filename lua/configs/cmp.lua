local ok, cmpConfig = pcall(require, "cmp")
if not ok then return end

cmpConfig.setup {

	snippet = {
		expand = function(args)
			require "luasnip".lsp_expand(args.body)
		end,
	},

	mapping = {
		["<C-p>"] = cmpConfig.mapping.select_prev_item(),
		["<C-n>"] = cmpConfig.mapping.select_next_item(),
		["<C-d>"] = cmpConfig.mapping.scroll_docs(-4),
		["<C-f>"] = cmpConfig.mapping.scroll_docs(4),
		["<C-Space>"] = cmpConfig.mapping.complete(),
		["<C-e>"] = cmpConfig.mapping.close(),
		["<CR>"] = cmpConfig.mapping.confirm {
			behavior = cmpConfig.ConfirmBehavior.Replace,
			select = false,
		},
		["<Tab>"] = cmpConfig.mapping(function(fallback)
			if cmpConfig.visible() then
				cmpConfig.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s", }),
		["<S-Tab>"] = cmpConfig.mapping(function(fallback)
			if cmpConfig.visible() then
				cmpConfig.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(
					vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
					""
				)
			else
				fallback()
			end
		end, { "i", "s", }),
	},

	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" }
	},
}
