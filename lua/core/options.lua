local g = vim.g
local opt = vim.opt
local file_extension =  vim.fn.expand('%:e')
local is_cpp_or_hpp = file_extension == 'cpp' or file_extension == 'hpp'

local global_options = {
	list = true,
	tabstop = is_cpp_or_hpp and 2 or 4,
	smarttab = true,
	expandtab = is_cpp_or_hpp and true or false,
	shiftwidth = is_cpp_or_hpp and 2 or 4,
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
	scrolloff = 5
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
