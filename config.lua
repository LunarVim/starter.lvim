lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.breadcrumbs.active = true
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.dap.active = true
-- lvim.builtin.terminal.shell = "pwsh.exe -NoLogo"

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"rust",
	"toml"
}
lvim.builtin.treesitter.highlight.enable = true

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
	{ command = "rustfmt", filetypes = { "rust" } },
}

local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("rust_analyzer")


lvim.plugins = {
	{
		"simrat39/rust-tools.nvim",
		-- ft = { "rust", "rs" }, -- IMPORTANT: re-enabling this seems to break inlay-hints
		config = function()
			require("rust-tools").setup {
				tools = {
					executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
					reload_workspace_from_cargo_toml = true,
					inlay_hints = {
						auto = true,
						only_current_line = false,
						show_parameter_hints = true,
						parameter_hints_prefix = "<-",
						other_hints_prefix = "=>",
						max_len_align = false,
						max_len_align_padding = 1,
						right_align = false,
						right_align_padding = 7,
						highlight = "Comment",
					},
					hover_actions = {
						border = {
							{ "╭", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╮", "FloatBorder" },
							{ "│", "FloatBorder" },
							{ "╯", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╰", "FloatBorder" },
							{ "│", "FloatBorder" },
						},
						auto_focus = true,
					},
				},
				server = {
					on_init = require("lvim.lsp").common_on_init,
					on_attach = function(client, bufnr)
						require("lvim.lsp").common_on_attach(client, bufnr)
						local rt = require "rust-tools"
						-- Hover actions
						vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
						-- Code action groups
						vim.keymap.set("n", "<leader>lA", rt.code_action_group.code_action_group, { buffer = bufnr })
					end,
				},
			}
		end,
	},
	{
		"saecki/crates.nvim",
		tag = "v0.3.0",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end
	}
}
