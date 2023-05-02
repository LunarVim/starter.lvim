------------------------------------------------------------------------
--                              Settings                              --
------------------------------------------------------------------------

lvim.format_on_save = false
lvim.lsp.diagnostics.virtual_text = false
-- lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

-- All the treesitter parsers you want to install. If you want all of them, just
-- replace everything with "all".
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

------------------------------------------------------------------------
--                                LSP                                 --
------------------------------------------------------------------------

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
pcall(function() require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python") end)

-- Supported test frameworks are unittest, pytest and django. By default it
-- tries to detect the runner by probing for pytest.ini and manage.py, if
-- neither are present it defaults to unittest.
pcall(function() require("dap-python").test_runner = "pytest" end)

------------------------------------------------------------------------
--                           Extra Plugins                            --
------------------------------------------------------------------------

-------------
--  Magma  --
-------------

-- Extra info: https://github.com/dccsillag/magma-nvim#customization
vim.g.magma_image_provider = "kitty"
vim.g.magma_automatically_open_output = true
vim.g.magma_wrap_output = false
vim.g.magma_output_window_borders = false
vim.g.magma_cell_highlight_group = "CursorLine"
vim.g.magma_save_path = vim.fn.stdpath "data" .. "/magma"

------------------------------------------------------------------------
--                              Mappings                              --
------------------------------------------------------------------------

lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["df"] = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" }
lvim.builtin.which_key.vmappings["d"] = {
  name = "Debug",
  s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
}

-- For neotest to pick up the test functions, they need to be saved in a file
-- called: test_*.py and each function needs to start with def test_*(...):
lvim.builtin.which_key.mappings["n"] = {
  name = "Neotest",
  a = { "<CMD>lua require('neotest').run.attach()<CR>", "Attach to the nearest test" },
  c = { "<CMD>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Run the current file" },
  d = { "<CMD>lua require('neotest').run.run({strategy = 'dap'})<CR>", "Debug the nearest test" },
  e = { "<CMD>lua require('neotest').output.open({ enter = true, auto_close = true })<CR>", "Open the output of a test result" },
  j = { "<CMD>lua require('neotest').jump.prev({ status = 'failed' })<CR>", "Jump to next error" },
  k = { "<CMD>lua require('neotest').jump.next({ status = 'failed' })<CR>", "Jump to previous error" },
  n = { "<CMD>lua require('neotest').run.run()<CR>", "Run the nearest test" },
  s = { "<CMD>lua require('neotest').run.stop()<CR>", "Stop the nearest test" },
  S = { "<CMD>lua require('neotest').summary.toggle()<CR>", "Toggle the summary window" },
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

-- Additional Plugins
lvim.plugins = {
  -- You can switch between vritual environmnts.
  "AckslD/swenv.nvim",
  "mfussenegger/nvim-dap-python",
  {
    "nvim-neotest/neotest",
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
          }),
        },
      })
    end,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
  },
  {
    -- You can generate docstrings automatically.
    "danymat/neogen",
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
  -- You can run blocks of code like jupyter notebook.
  { "dccsillag/magma-nvim", run = ":UpdateRemotePlugins" },
}
