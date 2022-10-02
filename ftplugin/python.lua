local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  d = {
    name = "Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
  },
  y = {
    name = "Python",
    i = { "<Cmd>MagmaInit<CR>", "Init Magma" },
    d = { "<Cmd>MagmaDeinit<CR>", "Deinit Magma" },
    e = { "<Cmd>MagmaEvaluateLine<CR>", "Evaluate Line" },
    r = { "<Cmd>MagmaReevaluateCell<CR>", "Re evaluate cell" },
    D = { "<Cmd>MagmaDelete<CR>", "Delete cell" },
    s = { "<Cmd>MagmaShowOutput<CR>", "Show Output" },
    R = { "<Cmd>MagmaRestart!<CR>", "Restart Magma" },
    S = { "<Cmd>MagmaSave<CR>", "Save" },
  },
}

local vmappings = {
  y = {
    name = "Python",
    e = { "<Cmd>MagmaEvaluateVisual<CR>", "Evaluate Highlighted Line" },
  },
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
