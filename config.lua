-- ===================================== General Section ============================================
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "tokyonight"
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.breadcrumbs.active = true


-- =================================== Treesitter Section ===========================================
lvim.builtin.treesitter.ensure_installed = {
  "go",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true


-- ======================================= LSP Section ==============================================
-- Will override the LSP formatting capabilities if any exist


-- ======================================= Dap Section ==============================================
lvim.builtin.dap.active = true

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

-- dapui.setup()
dapui.setup {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has "nvim-0.7",
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        -- "stacks",
        -- "watches",
      },
      size = 40, -- 40 columns
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  },
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open {}
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close {}
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close {}
end


-- ===================================== Plugins Section ============================================
lvim.plugins = {
  "rcarriga/nvim-dap-ui",
}


-- ================================= Go IDE Specific Section ========================================
GoIDE = {
  rayx_gonvim = true,
  rayx_gonvim_format_on_save = true
}

M = {}

function M.start()
  -- if not GoIDE.go_ide.rayx_gonvim then
  --   M.setup_gopls()
  --   return
  -- end

  lvim.plugins = vim.tbl_extend("force", lvim.plugins, {
    "ray-x/go.nvim",
    "ray-x/guihua.lua",
  })

  local status_ok, rayx_go_nvim = pcall(require, "go")
  if not status_ok then
    return
  end

  M.setup_govim(rayx_go_nvim)

  if GoIDE.rayx_gonvim_format_on_save then
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

function M.setup_gopls()
  local formatters = require("lvim.lsp.null-ls.formatters")
  formatters.setup({
    { command = "goimports", filetypes = { "go" } },
  })

  local lsp_manager = require("lvim.lsp.manager")
  lsp_manager.setup("gopls")
end

M.start()
