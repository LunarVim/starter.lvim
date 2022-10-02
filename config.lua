lvim.log.level = "warn"
lvim.format_on_save = false
lvim.lsp.diagnostics.virtual_text = true
lvim.leader = "space"

-- After changing plugin config exit and reopen LunarVim, run :PackerSync
-- :PackerCompile.
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.breadcrumbs.active = true
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.dap.active = true

-- All the treesitter parsers you want to install. If you want all of them, just
-- replace everything with "all".
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pylsp" })

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
  -- You can view all the variables, functions, classes, etc.
  "simrat39/symbols-outline.nvim",
  -- Allows you to debug with a better ui.
  "rcarriga/nvim-dap-ui",
}

require "user.magma"
require "user.symbols-outline"
require "user.dap-ui"
