lvim.builtin.treesitter.ensure_installed = {
  "python",
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, }

lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" } } }

lvim.plugins = {
  "ChristianChiarulli/swenv.nvim",
  "stevearc/dressing.nvim",
}

lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
