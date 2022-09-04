local ok, packer = pcall(require, "packer")
if not ok then error("Can't load packer") return end

local use = packer.use

packer.startup(function()
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
				ensure_installed = { "c", "cpp", "lua", "python" },
				highlight = {
					enable = true,
					use_languagetree = true,
				},
			}
		end,
	}

	use {
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
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
		setup = function()
			require "core.mappings".nvimTree()
		end
	}

	use {
		"neovim/nvim-lspconfig",
		config = function()
			require "configs.lspconfig"
		end,
		setup = function()
			require "core.mappings".lspConfig()
		end
	}

	use {
		"rafamadriz/friendly-snippets",
		module = { "cmp", "cmp_nvim_lsp" },
		event = "InsertEnter"
	}

	use {
		"hrsh7th/nvim-cmp",
		after = "friendly-snippets",
		config = function()
			require "configs.cmp"
		end
	}

	use {
		"L3MON4D3/LuaSnip",
		after = "nvim-cmp",
		wants = "friendly-snippets",
		config = function()
			require "configs.others".luaSnip()
		end
	}

	use {
		"saadparwaiz1/cmp_luasnip",
		after = "LuaSnip"
	}

	use {
		"hrsh7th/cmp-nvim-lua",
		after = "cmp_luasnip",
	}

	use {
		"hrsh7th/cmp-nvim-lsp",
		after = "cmp-nvim-lua",
	}

	use {
		"hrsh7th/cmp-buffer",
		after = "cmp-nvim-lsp",
	}

	use {
		"hrsh7th/cmp-path",
		after = "cmp-buffer",
	}

	use {
		"numToStr/Comment.nvim",
		module = "Comment",
		keys = { "gc", "gb" },
		config = function ()
			require "Comment".setup {}
		end,
	}

	use {
		"windwp/nvim-autopairs",
		opt = true,
		event = "InsertEnter",
		config = function ()
			require "configs.others".autoPairs()
		end
	}
end)
