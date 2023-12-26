local opt = vim.opt -- for conciseness

local options = {
	-- line numbers
	relativenumber = true,
	number = true,

	-- tabs & indentation
	tabstop = 2,
	shiftwidth = 2,
	expandtab = true,
	autoindent = true,

	-- line wrapping
	wrap = false,

	-- search settings
	ignorecase = true,
	smartcase = true,

	-- cursor line
	cursorline = true,

	-- appearance
	termguicolors = true,
	background = "dark",
	signcolumn = "yes",

	-- backspace
	backspace = "indent,eol,start",

	-- split windows
	splitright = true,
	splitbelow = true,
}

opt.iskeyword:append("-")

-- clipboard
opt.clipboard:append("unnamedplus")

-- loops through the options keyed table and assign each property and its value to the opt table
for key, value in pairs(options) do
	opt[key] = value
end
