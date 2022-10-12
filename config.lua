lvim.format_on_save = false
lvim.lsp.diagnostics.virtual_text = true

lvim.builtin.treesitter.highlight.enable = true

lvim.builtin.treesitter.ensure_installed = { "c_sharp" }

local capabilities = require("lvim.lsp").common_capabilities()

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

require("lvim.lsp.manager").setup("omnisharp", {
  cmd = mason_path .. "/bin/omnisharp",
  on_attach = require("lvim.lsp").common_on_attach,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = capabilities,
})

lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.netcoredbg = {
    type = "executable",
    command = mason_path .. "bin/netcoredbg"
    args = {'--interpreter=vscode'}
  }

  dap.configurations.cs = {
    {
      type = "netcoredbg",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
      end,
    },
  }

  dap.configurations.fs = dap.configurations.cs

end

vim.g.OmniSharp_server_path = mason_path .. "/bin/omnisharp"

lvim.plugins = {
  "OmniSharp/omnisharp-vim",
}

