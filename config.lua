lvim.builtin.treesitter.ensure_installed = {
	"scala",
}

-- function to display metals status in the statusline
local function metals_status()
	local status = vim.g["metals_status"]
	if status == nil then
		return ""
	else
		return status
	end
end

-- As per the nvim-metals documentation, you should hook up metals_status into your
-- status bar https://github.com/scalameta/nvim-metals/blob/main/doc/metals.txt#L101-L114
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_c = {
	-- NOTE: There is no way to append a component, so we need to include the components
	-- here that are already supplied by lunarvim in `lualine_c`
	components.diff,
	components.python_env,
	metals_status,
}

lvim.builtin.which_key.mappings["L"] = {
	name = "Metals",
	u = { "<Cmd>MetalsUpdate<CR>", "Update Metals" },
	i = { "<Cmd>MetalsInfo<CR>", "Metals Info" },
	r = { "<Cmd>MetalsRestartBuild<CR>", "Restart Build Server" },
	d = { "<Cmd>MetalsRunDoctor<CR>", "Metals Doctor" },
}

lvim.plugins = {
	"scalameta/nvim-metals",
}

-- Setting up the lsp initialisation in an autocmd
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.scala", "*.sbt", "*.sc" },
	callback = function()
		local metals_config = require("metals").bare_config()
		metals_config.on_attach = function(client, bufnr)
			require("lvim.lsp").common_on_attach(client, bufnr)
			require("metals").setup_dap()
		end
		metals_config.init_options.statusBarProvider = "on"
		metals_config.settings = {
			showImplicitArguments = false,
			showInferredType = true,
			excludedPackages = {},
		}
		require("metals").initialize_or_attach(metals_config)
	end,
	group = nvim_metals_group,
})
