lvim.format_on_save = false
lvim.lsp.diagnostics.virtual_text = false

-- All the treesitter parsers you want to install. If you want all of them, just
-- replace everything with "all".
lvim.builtin.treesitter.ensure_installed = {
  "javascript",
  "typescript",
}

-- Setup lsp.
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })

-- Customize tsserver by changing the flags below.
local tsserver_flags = {}
local capabilities = require("lvim.lsp").common_capabilities()

require("lvim.lsp.manager").setup("tsserver", {
  cmd = { "clangd", unpack(tsserver_flags) },
  on_attach = require("lvim.lsp").common_on_attach,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = capabilities,
})

-- Set a formatter.
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "prettier", filetypes = { "javascript", "typescript" } },
})

-- Set a linter.
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { command = "eslint", filetypes = { "javascript", "typescript" } },
})

-- Additional Plugins
lvim.plugins = {}
