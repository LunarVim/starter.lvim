lvim.format_on_save = false
lvim.lsp.diagnostics.virtual_text = false

-- All the treesitter parsers you want to install. If you want all of them, just
-- replace everything with "all".
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- Set a formatter.
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
}

-- Set a linter.
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
}

-- TODO: debugpy installed by default
-- Setup dap for python
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")

-- Supported test frameworks are unittest, pytest and django. By default it
-- tries to detect the runner by probing for pytest.ini and manage.py, if
-- neither are present it defaults to unittest.
require("dap-python").test_runner = "pytest"

-- Mappings
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["df"] = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" }
lvim.builtin.which_key.vmappings["d"] = {
  name = "Debug",
  s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
}

lvim.builtin.which_key.mappings["j"] = {
  name = "Jupyter",
  i = { "<Cmd>MagmaInit<CR>", "Init Magma" },
  d = { "<Cmd>MagmaDeinit<CR>", "Deinit Magma" },
  e = { "<Cmd>MagmaEvaluateLine<CR>", "Evaluate Line" },
  r = { "<Cmd>MagmaReevaluateCell<CR>", "Re evaluate cell" },
  D = { "<Cmd>MagmaDelete<CR>", "Delete cell" },
  s = { "<Cmd>MagmaShowOutput<CR>", "Show Output" },
  R = { "<Cmd>MagmaRestart!<CR>", "Restart Magma" },
  S = { "<Cmd>MagmaSave<CR>", "Save" },
}

lvim.builtin.which_key.vmappings["j"] = {
  name = "Jupyter",
  e = { "<esc><cmd>MagmaEvaluateVisual<cr>", "Evaluate Highlighted Line" },
}

lvim.builtin.which_key.mappings["P"] = {
  name = "Python",
  i = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Pick Env" },
  d = { "<cmd>lua require('swenv.api').get_current_venv()<cr>", "Show Env" },
}

-- Additional Plugins
lvim.plugins = {
  -- You can run blocks of code like jupyter notebook.
  "AckslD/swenv.nvim",
  "danymat/neogen",
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("neogen").setup {
        enabled = true,
        languages = {
          python = {
            template = {
              annotation_convention = "numpydoc",
            },
          },
        },
      }
    end,
  },
  { "dccsillag/magma-nvim", run = ":UpdateRemotePlugins" },
}
