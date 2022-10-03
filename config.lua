lvim.log.level = "warn"
lvim.format_on_save = false
lvim.leader = "space"
lvim.lsp.diagnostics.virtual_text = true

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.breadcrumbs.active = true
lvim.builtin.treesitter.highlight.enable = true
-- enable dap
lvim.builtin.dap.active = true

-- All the treesitter parsers you want to install. If you want all of them, just
-- replace everything with "all".
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- Setup lsp.

local pylsp_flags = {}

require("lvim.lsp.manager").setup("pylsp", {
  cmd = { "pyslp", unpack(pylsp_flags) },
  on_attach = require("lvim.lsp").common_on_attach,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

-- Set a formatter.
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
}

-- Set a linter.
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
}

-- Additional Plugins
lvim.plugins = {
  -- You can run blocks of code like jupyter notebook.
  "dccsillag/magma-nvim",
  config = function()
    require("user.magma").setup()
  end,
}
