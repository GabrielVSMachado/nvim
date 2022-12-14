local _ok, packer = pcall(require, "packer")
if not _ok then error("Can't load packer") return end

local use = packer.use

packer.startup(function()
  use "wbthomason/packer.nvim"

  use {
    'Mofiqul/vscode.nvim',
    config = function()
      require 'configs.colorscheme'
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
        view = {
          adaptive_size = true
        },
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
    requires = {
      "onsails/lspkind.nvim"
    },
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
    config = function()
      require "Comment".setup {}
    end,
  }

  use {
    "windwp/nvim-autopairs",
    opt = true,
    event = "InsertEnter",
    config = function()
      require "configs.others".autoPairs()
    end
  }

  use {
    "williamboman/mason.nvim",
    config = function()
      local ok_, module = pcall(require, "mason")
      if not ok_ then
        return
      end
      module.setup()
    end
  }

  use {
    'eduardomosko/header42.nvim',
    opt = true,
    cmd = { "Stdheader" },
    config = function()
      local ok, module = pcall(require, "header42")
      if not ok then
        error("Condn't load header42")
        return
      end
      module.setup({
        user = os.getenv("USER42"),
        mail = os.getenv("EMAIL_42")
      })
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      local ok, module = pcall(require, 'telescope')
      if not ok then return end

      module.setup {}
    end,
    setup = function()
      require("core.mappings").telescope()
    end
  }

  use {
    'glepnir/dashboard-nvim',
    config = function()
      require('configs.dashboard')
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    opt = true,
    event = "BufRead",
    config = function()
      local ok, module = pcall(require, 'indent_blankline')
      if not ok then
        vim.notify("Could'n load indent_blankline !!!")
        return
      end

      module.setup {
        show_current_context = true,
        show_current_context_start = false
      }
    end
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      local ok, module = pcall(require, "gitsigns")
      if not ok then
        vim.notify("Couldn't load gitsigns !!!")
        return
      end

      module.setup {
        on_attach = require "core.mappings".gitsigns
      }
    end
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local ok, module = pcall(require, 'null-ls')
      if not ok then
        vim.notify("Couldn't load null-ls module !!!")
        return
      end
      module.setup {
        debug = false,
        sources = {
          module.builtins.formatting.black,
          -- module.builtins.diagnostics.flake8
          -- module.builtins.code_actions.refactoring
        }
      }
    end
  }

  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require "configs.bufferline"
    end,
    setup = function()
      require "core.mappings".bufferline()
    end
  }

end)
