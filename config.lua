-- ===================================== General Section ============================================
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "tokyonight"
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.breadcrumbs.active = true

-- =================================== Treesitter Section ===========================================
lvim.builtin.treesitter.ensure_installed = {
	"php",
}

lvim.builtin.treesitter.highlight.enable = true

-- ======================================= LSP Section ==============================================
-- Will override the LSP formatting capabilities if any exist
local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("intelephense")

-- More information on how to install the debug adapter
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#PHP
local dap = require("dap")
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
dap.adapters.php = {
	type = "executable",
	command = "node",
	args = { mason_path .. "packages/php-debug-adapter/extension/out/phpDebug.js" },
}
dap.configurations.php = {
	{
		type = "php",
		request = "launch",
		name = "Listen for Xdebug",
		port = 9000,
	},
}

-- ======================================= Dap Section ==============================================
lvim.builtin.dap.active = true

-- Key Maps
lvim.builtin.which_key.vmappings["L"] = {
	name = "Debug",
	b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
	c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
	i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
	o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
	O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
	r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
	l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
	u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
	x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
}

-- ===================================== Plugins Section ============================================
lvim.plugins = {}
