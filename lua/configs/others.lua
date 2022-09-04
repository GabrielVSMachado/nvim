local M = {}

M.luaSnip = function()
	require "luasnip.loaders.from_vscode".lazy_load()

	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			if require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
				and not require('luasnip').session.jump_active
			then
				require('luasnip').unlink_current()
			end
		end
	})
end

M.autoPairs = function()
	local ok_autopairs, autopairs = pcall(require, "nvim-autopairs")
	local ok_cmp, cmp = pcall(require, "cmp")

	if not ok_autopairs or not ok_cmp then
		return
	end

	autopairs.setup({})
	local cmp_autopairs = require "nvim-autopairs.completion.cmp"
	cmp.event:on(
		'confirm_done',
		cmp_autopairs.on_confirm_done()
	)
end

return M
