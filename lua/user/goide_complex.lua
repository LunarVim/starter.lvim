local M = {}

function M.start()
  if GOIDE_CONFIG.format_on_save then
    M.setup_format_on_save_autocmd()
  end

  lvim.plugins = vim.tbl_extend("force", lvim.plugins, {
    "ray-x/go.nvim",
    "ray-x/guihua.lua",
  })

  local status_ok, rayx_go_nvim = pcall(require, "go")
  if not status_ok then
    return
  end

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

  -- Key Maps
  lvim.builtin.which_key.mappings["L"] = {
    name = "Debug",
    b = { "<cmd>GoBreakToggle<cr>", "Breakpoint" },
    s = { "<cmd>GoDebug<cr>", "Start" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
    r = { "<cmd>ReplToggle<cr>", "Repl" },
    l = { "<cmd>ReplRun<cr>", "Last" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
    t = { "<cmd>GoDebug test<cr>", "Debug Test" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
  }
end

function M.setup_format_on_save_autocmd()
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.go" },
    callback = function()
      vim.cmd([[silent! lua require('go.format').gofmt()]]) -- gofmt (gofumpt) only
      -- vim.cmd([[silent! lua require('go.format').goimport()]]) -- goimport + gofmt
    end,
  })
end

return M
