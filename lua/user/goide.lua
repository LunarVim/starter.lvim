local M = {
  go_ide = {
    rayx_gonvim = true,
    rayx_gonvim_format_on_save = true
  },
}

function M.start()
  if not M.go_ide.rayx_gonvim then
    M.setup_simple()
    return
  end

  lvim.plugins = vim.tbl_extend("force", lvim.plugins, {
    "ray-x/go.nvim",
    "ray-x/guihua.lua",
  })

  local status_ok, rayx_go_nvim = pcall(require, "go")
  if not status_ok then
    return
  end

  M.setup_govim(rayx_go_nvim)

  if M.go_ide.rayx_gonvim_format_on_save then
    M.setup_format_on_save_autocmd()
  end

end

function M.setup_govim(rayx_go_nvim)
  local lvim_lsp = require("lvim.lsp")
  local capabilities = lvim_lsp.common_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  -- For more setup options please check this https://github.com/ray-x/go.nvim#configuration
  rayx_go_nvim.setup({
    goimport = "gopls", -- goimport command, can be gopls[default] or goimport
    gofmt = "gofumpt", --gofmt cmd,
    -- max_line_len = 140, -- If you want golines to auto format your code to be max of 140 characters
    lsp_keymaps = false, -- Disables ray-x/go.nvim specific LSP mappings
    dap_debug = true, -- set to false to disable dap
    dap_debug_gui = true, -- set to true to enable dap gui, highly recommend
  })
end

function M.setup_format_on_save_autocmd()
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.go" },
    callback = function()
      vim.cmd([[silent! lua require('go.format').gofmt()]]) -- gofmt (gofu) only
      -- vim.cmd([[silent! lua require('go.format').goimport()]]) -- goimport + gofmt
    end,
  })
end

function M.setup_simple()
  lvim.plugins = vim.tbl_extend("force", lvim.plugins, {
    "leoluz/nvim-dap-go",
  })

  -- Add goimports formatter
  local formatters = require("lvim.lsp.null-ls.formatters")
  formatters.setup({
    { command = "goimports", filetypes = { "go" } },
    { command = "gofumpt", filetypes = { "go" } },
  })

  local lsp_manager = require("lvim.lsp.manager")
  lsp_manager.setup("gopls")

  require("user.dapgo")
end

return M
