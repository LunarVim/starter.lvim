lvim.format_on_save = true

lvim.builtin.treesitter.ensure_installed = {
  "javascript",
  "json",
  "lua",
  "typescript",
  "tsx",
  "css",
  "elixir",
  "heex",
}

lvim.lsp.installer.setup.ensure_installed = {
  "sumeko_lua",
  "css-lsp",
  "typescript-language-server",
  "tailwindcss-language-server",
}

-- Don't allow Mason to handle elixir-ls
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "elixirls" })

-- Additional Plugins
elixir_ls_base_opts = {
  tag = "v0.11.0",
}

lvim.plugins = {
  { -- use "mhanberg/elixir.nvim" if you don't need the debugger
    "tiberiuc/elixir.nvim", branch = "add-support-for-dap-debugger-path",
    requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
    config = function()
      local elixir = require("elixir")
      local opts = {
        capabilities = require("lvim.lsp").common_capabilities(),
        on_attach = require("lvim.lsp").common_on_attach,
        on_init = require("lvim.lsp").common_on_init,
        settings = elixir.settings({
          dialyzerEnabled = true,
          fetchDeps = false,
          enableTestLenses = true,
          suggestSpecs = true,
        }),
      }
      opts = vim.tbl_extend("keep", elixir_ls_base_opts, opts)
      elixir.setup(opts)
    end,
  }
}

lvim.builtin.which_key.mappings["E"] = {
  name = "Elixir",
  p = {
    name = "Pipe",
    f = { "<cmd>ElixirFromPipe<Cr>", "Convert pipe operator to function call" },
    t = { "<cmd>ElixirToPipe<cr>", "Convert function call to pipe operator" },
  },
  m = { "<cmd>ElixirExpandMacro<Cr>", "Expand macro" },
  o = { "<cmd>ElixirOutputPanel<Cr>", "Show Elixir output panel" },
  r = { "<cmd>ElixirRestart<Cr>", "Restart LSP" },
}

-- Allow tailwindcss inside heex and elixir files for Phoenix projects
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tailwindcss" })
local tailwindcss_lsp_opts = {
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern("assets/tailwind.config.js", "tailwind.config.js",
      "tailwind.config.cjs", "tailwind.js",
      "tailwind.cjs")(fname)
  end,
  init_options = {
    userLanguages = { heex = "html", elixir = "html" }
  },
}
require("lvim.lsp.manager").setup("tailwindcss", tailwindcss_lsp_opts)

-- DAP configuration
local dap = require('dap')

dap.adapters.mix_task = {
  type = 'executable',
  command = require("elixir.language_server").debugger_path(elixir_ls_base_opts),
  args = {}
}

dap.configurations.elixir = {
  {
    type = "mix_task",
    name = "mix test",
    task = 'test',
    taskArgs = { "--trace" },
    request = "launch",
    startApps = true, -- for Phoenix projects
    projectDir = "${workspaceFolder}",
    requireFiles = {
      "test/**/test_helper.exs",
      "test/**/*_test.exs"
    }
  },
}
