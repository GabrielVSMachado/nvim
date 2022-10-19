local g = vim.g
local opt = vim.opt

local global_options = {
	list = true,
	tabstop = 2,
	smarttab = true,
	expandtab = true,
	shiftwidth = 2,
	autoindent = true,
	smartindent = true,
	smartcase = true,
	breakindent = true,
	number = true,
	relativenumber = true,
	listchars="trail:·,tab:⇝ ,eol:⮐",
	mouse = 'a',
	clipboard = "unnamedplus",
	undolevels = 400,
	undofile = true,
	scrolloff = 5,
  termguicolors=true,
  colorcolumn='80'
}

local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit"
}


for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

for key, value in pairs(global_options) do
	opt[key] = value
end
