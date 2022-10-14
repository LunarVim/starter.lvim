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
-- Dap
------------------------
local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
  return
end

dapgo.setup()

------------------------
-- LSP
------------------------
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })

local function set_keymaps(buffer)
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = buffer, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  local mappings = {
    C = {
      name = "Go",
      i = { "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies" },
      t = { "<cmd>GoMod tidy<cr>", "Tidy" },
      a = { "<cmd>GoTestAdd<Cr>", "Add Test" },
      A = { "<cmd>GoTestsAll<Cr>", "Add All Tests" },
      e = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
      g = { "<cmd>GoGenerate<Cr>", "Go Generate" },
      f = { "<cmd>GoGenerate %<Cr>", "Go Generate File" },
      c = { "<cmd>GoCmt<Cr>", "Generate Comment" },
    },
    D = {
      name = "Debug",
      T = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test" }
    }
  }
  which_key.register(mappings, opts)
end

local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("golangci_lint_ls", {
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_manager.setup("gopls", {
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
    set_keymaps(bufnr)
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
