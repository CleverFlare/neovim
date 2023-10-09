return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")

		local if_nil = vim.F.if_nil

		local default_terminal = {
			type = "terminal",
			command = nil,
			width = 69,
			height = 8,
			opts = {
				redraw = true,
				window_config = {},
			},
		}

		local default_header = {
			type = "text",
			val = {
				"███████╗██╗      █████╗ ██████╗ ███████╗",
				"██╔════╝██║     ██╔══██╗██╔══██╗██╔════╝",
				"█████╗  ██║     ███████║██████╔╝█████╗  ",
				"██╔══╝  ██║     ██╔══██║██╔══██╗██╔══╝  ",
				"██║     ███████╗██║  ██║██║  ██║███████╗",
				"╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝",
			},
			opts = {
				position = "center",
				hl = "Type",
				-- wrap = "overflow";
			},
		}

		local footer = {
			type = "text",
			val = "",
			opts = {
				position = "center",
				hl = "Number",
			},
		}

		local leader = "SPC"

		--- @param sc string
		--- @param txt string
		--- @param keybind string? optional
		--- @param keybind_opts table? optional
		local function button(sc, txt, keybind, keybind_opts)
			local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

			local opts = {
				position = "center",
				shortcut = sc,
				cursor = 3,
				width = 50,
				align_shortcut = "right",
				hl_shortcut = "Keyword",
			}
			if keybind then
				keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
				opts.keymap = { "n", sc_, keybind, keybind_opts }
			end

			local function on_press()
				local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
				vim.api.nvim_feedkeys(key, "t", false)
			end

			return {
				type = "button",
				val = txt,
				on_press = on_press,
				opts = opts,
			}
		end

		local buttons = {
			type = "group",
			val = {
				button("e", "  > New File", "<cmd>ene<CR>"),
				button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
				button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
				button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
				button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
				button("q", " > Quit NVIM", "<cmd>qa<CR>"),
			},
			opts = {
				spacing = 1,
			},
		}

		local section = {
			terminal = default_terminal,
			header = default_header,
			buttons = buttons,
			footer = footer,
		}

		local config = {
			layout = {
				{ type = "padding", val = 12 },
				section.header,
				{ type = "padding", val = 2 },
				section.buttons,
				section.footer,
			},
			opts = {
				margin = 5,
			},
		}

		-- Send config to alpha
		alpha.setup(config)
	end,
}
