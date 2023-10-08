-- pcall here is used to run a function with some arguments and return a status to indicate success or failure
-- you can replace this whole thing with just vim.cmd("colorscheme catppuccin")
local status, _ = pcall(vim.cmd, "colorscheme catppuccin")
if not status then
	print("Colorscheme not found!")
	return
end
