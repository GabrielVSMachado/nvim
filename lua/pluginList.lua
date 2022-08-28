local ok, packer = pcall(require, "packer")
if not ok then error("Can't load packer") return end

local use = packer.use

packer.startup(function ()
	use "wbthomason/packer.nvim"

	use {
		"catppuccin/nvim",
		as = "catppuccin",
		event = "VimEnter",
		config = function()
			require "configs.colorscheme"
		end
	}

	use {
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		run = ":TSUpdate",
		config = function()
			local ok, ts = pcall(require, "nvim-treesitter.configs")
			if not ok then return end

			ts.setup {
				ensure_installed = {"c", "cpp", "lua", "python"},
				highlight = {
					enable = true,
					use_languagetree = true,
				},
			}
		end,
	}

	use {
		"kyazdani42/nvim-tree.lua",
		cmd = {"NvimTreeToggle", "NvimTreeFocus"},
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			local ok, nvimTree = pcall(require, "nvim-tree")
			if not ok then return end

			nvimTree.setup {
				sort_by = "case_sensitive",
				filters = {
					dotfiles = false,
				},
			}
		end,
	}
end)
