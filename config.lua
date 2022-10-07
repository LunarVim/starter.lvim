------------------------
-- Treesitter
------------------------
lvim.builtin.treesitter.ensure_installed = {
  "go",
  "gomod",
}

------------------------
-- Plugins
------------------------
lvim.plugins = {
  "olexsmir/gopher.nvim",
  "leoluz/nvim-dap-go",
}

------------------------
-- Formatting
------------------------
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "goimports", filetypes = { "go" } },
  { command = "gofumpt", filetypes = { "go" } },
}

lvim.format_on_save = {
  pattern = { "*.go" },
}


------------------------
-- LSP
------------------------
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })

local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("golangci_lint_ls", {
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_manager.setup("gopls", {
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
  settings = {
    gopls = {
      usePlaceholders = true,
      gofumpt = true,
      codelenses = {
        generate = false,
        gc_details = true,
        test = true,
        tidy = true,
      },
    },
  },
})

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
  return
end

gopher.setup {
  commands = {
    go = "go",
    gomodifytags = "gomodifytags",
    gotests = "gotests",
    impl = "impl",
    iferr = "iferr",
  },
}

------------------------
-- Language Key Mappings
------------------------
lvim.builtin.which_key.mappings["L"] = {
  name = "Go",
  i = { "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies" },
  t = { "<cmd>GoMod tidy<cr>", "Tidy" },
  a = { "<cmd>GoTestAdd<Cr>", "Add Test" },
  A = { "<cmd>GoTestsAll<Cr>", "Add All Tests" },
  e = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
  g = { "<cmd>GoGenerate<Cr>", "Go Generate" },
  f = { "<cmd>GoGenerate %<Cr>", "Go Generate File" },
  c = { "<cmd>GoCmt<Cr>", "Generate Comment" },
}

------------------------
-- Dap
------------------------
local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
  return
end

dapgo.setup()

lvim.builtin.which_key.mappings["dT"] = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test" }
