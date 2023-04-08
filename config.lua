-- This whole setup assumes you are using LunarVim Nightly with Lazy as the plugin manager
-- LSP
-- For me the default LSP setup automatically installed by LunarVim is fine

-- FORMATTER
lvim.format_on_save = true -- Change this to false if you prefer

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    extra_args = { "--print-width", "100" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
}

-- LINTER
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint_d", filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" } },
}

-- DEBUGGER CONFIG
reload "user.debugger"

-- DEBUGGER PLUGINS
lvim.plugins = {
  -- I prefer to install the plugins for the debugger this way following the official nvim-dap-vscode-js documentation on github by msxdev instead of using mason
  { "mxsdev/nvim-dap-vscode-js" },
  {
    "microsoft/vscode-js-debug",
    lazy = true,
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },
}
