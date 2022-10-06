local M = {}

function M.start()
  if GOIDE_CONFIG.format_on_save then
    lvim.format_on_save = true
  end

  lvim.plugins = vim.tbl_extend("force", lvim.plugins, {
    "leoluz/nvim-dap-go",
  })

  -- Add formatters
  local formatters = require("lvim.lsp.null-ls.formatters")
  formatters.setup({
    { command = "goimports", filetypes = { "go" } },
    { command = "gofumpt", filetypes = { "go" } },
  })

  -- LSP Server
  vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })
  local lsp_manager = require("lvim.lsp.manager")
  lsp_manager.setup("gopls", {
    on_attach = require("lvim.lsp").common_on_attach,
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = true,
          test = true,
          tidy = true,
        },
      },
    },
  })

  -- Dap
  local status_ok, dapgo = pcall(require, "dap-go")
  if not status_ok then
    return
  end

  dapgo.setup()


  -- Key Maps
  lvim.builtin.which_key.mappings["L"] = {
    name = "Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
    t = { "<cmd>lua require'dap-go'.debug_test()<cr>", "Debug Test" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
  }
end

return M
