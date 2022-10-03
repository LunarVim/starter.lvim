lvim.log.level = "warn"
lvim.format_on_save = false
lvim.leader = "space"
lvim.lsp.diagnostics.virtual_text = true

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.breadcrumbs.active = true
lvim.builtin.treesitter.highlight.enable = true
-- enable dap
lvim.builtin.dap.active = true

-- auto install treesitter parsers
lvim.builtin.treesitter.ensure_installed = { "cpp", "c" }

-- setup clangd

-- customize clangd by changing the flags below
local clangd_flags = {
  "--background-index",
  "--fallback-style=google",
  "--all-scopes-completion",
  "--clang-tidy",
  "--log=error",
  "--completion-style=detailed",
  "--pch-storage=disk",
  "--folding-ranges",
  "--enable-config",
}

require("lvim.lsp.manager").setup("clangd", {
  cmd = { "clangd", unpack(clangd_flags) },
  on_attach = require("lvim.lsp").common_on_attach,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

-- Set a formatter.
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "clang_format", filetypes = { "cpp", "c" } },
}

-- Set a linter.
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "cpplint", filetypes = { "cpp", "c" } },
}

-- install codelldb with :MasonInstall codelldb
-- configure nvim-dap (codelldb)
lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.codelldb = {
    type = "server",
  capabilities = require("lvim.lsp").common_capabilities()
})

-- install codelldb with :MasonInstall codelldb
-- configure nvim-dap (codelldb)
lvim.builtin.dap.on_config_done = function(dap)

  dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
      -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
      command = "codelldb",
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = true,
    },
  }

  dap.configurations.c = dap.configurations.cpp
end

lvim.plugins = {
  -- nvim-dap-virtual-text can be replaced with rcarriga/nvim-dap-ui
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  }
}
