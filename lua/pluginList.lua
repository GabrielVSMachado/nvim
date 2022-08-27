local ok, packer = pcall(require, "packer")
if not ok then error("Can't load packer") return end

packer.startup(function (use)
	use "wbthomason/packer.nvim"

	use {
		"catppuccin/nvim",
		as = "catppuccin",
		event = "VimEnter",
		config = function()
			require "configs.colorscheme"
		end
	}
end)
