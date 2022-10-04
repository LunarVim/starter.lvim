lvim.log.level = "warn"
lvim.format_on_save = true
lvim.leader = "space"

-- uncomment the line below to disable icons
-- lvim.use_icons = false

------------------------------------------------------------------------
-- colorscheme
-- choose from "tokyonight", "catppuccin", "kanagawa"
------------------------------------------------------------------------
lvim.colorscheme = "tokyonight"

------------------------------------------------------------------------
-- builtin plugins configs

-- After changing plugin config exit and reopen LunarVim -
-- Run :PackerInstall :PackerCompile
------------------------------------------------------------------------
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.breadcrumbs.active = true


------------------------------------------------------------------------
-- auto install treesitter parsers
------------------------------------------------------------------------
lvim.builtin.treesitter.ensure_installed = {
  "c",
  "cpp",
  "javascript",
  "typescript",
  "tsx",
  "json",
  "lua",
  "html",
  "python",
  "css",
  "scss",
  "yaml",
  "toml",
  "go",
  "bash",
  "dockerfile",
  "rust",
}


------------------------------------------------------------------------
-- LSP settings
------------------------------------------------------------------------
lvim.lsp.diagnostics.virtual_text = false

-- language server in the table below will automatically be installed
lvim.lsp.installer.setup.ensure_installed = {
  "sumeko_lua",
  "jsonls",
  "pyright",
  "tsserver",
  "html",
  "yamlls",
  "dockerls",
  "bashls",
  "taplo",
}

-- language servers added to the skipped_servers table will not be -
-- automatically configured by LunarVim

-- Add servers to the skipped_servers table when manual configuration
-- of a language server is needed
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls", "rust_analyzer", "clangd" })

-- See below the examples of manual configuration of `gopls`, `clangd` -
-- and `rust_analyzer`
------------------------------------------------------------------------
-- Manual setup of language servers
------------------------------------------------------------------------

local lsp_manager = require "lvim.lsp.manager"
local on_init = require("lvim.lsp").common_on_init
local on_attach = require("lvim.lsp").common_on_attach
local capabilities = require("lvim.lsp").common_capabilities()

-- clangd
local clangd_flags = {
  "--offset-encoding=utf-16",
  "--fallback-style=google",
  "--enable-config",
  "--clang-tidy",
}

local clangd_capabilities = capabilities
clangd_capabilities.offsetEncoding = { "utf-16" }

-- clangd
lsp_manager.setup("clangd", {
  cmd = { "clangd", unpack(clangd_flags) },
  on_init = on_init,
  on_attach = on_attach,
  capabilities = clangd_capabilities,
})

-- rust_analyzer
lsp_manager.setup("rust_analyzer", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        enable = true,
        command = "clippy",
      },
    },
  },
})

-- gopls
lsp_manager.setup("gopls", {
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = true,
        generate = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
      },
      usePlaceholders = true,
      analyses = {
        fieldalignment = true,
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusedwrite = true,
      },
      staticcheck = true,
    },
  },
})

------------------------------------------------------------------------
-- formatters
------------------------------------------------------------------------
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    filetypes = {
      "json",
      "jsonc",
      "yaml",
      "markdown",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "css",
      "scss",
      "html",
    },
  },
  { command = "stylua", filetypes = { "lua" } },
  { command = "goimports", filetypes = { "go", "gomod" } },
  { command = "shfmt", filetypes = { "sh" } },
  { command = "rustfmt", filetypes = { "rust" } },
  { command = "black", filetypes = { "python" } },
}

------------------------------------------------------------------------
-- linters
------------------------------------------------------------------------
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  { command = "golangci_lint", filetypes = { "go" } },
  { command = "hadolint", filetypes = { "dockerfile" } },
  { command = "shellcheck", filetypes = { "sh" } },
  {
    command = "luacheck",
    filetypes = { "lua" },
    args = { "--globals", "vim", "--formatter", "plain", "--codes", "--ranges", "--filename", "$FILENAME", "-" },
  },

  { command = "yamllint", filetypes = { "yaml" } },
  { command = "eslint_d", filetyps = { "javascript", "javascriptreact", "typescript", "typescriptreact" } },
}



------------------------------------------------------------------------
-- Plugins
------------------------------------------------------------------------
lvim.plugins = {

  -- addtional colorschemes
  { "rebelot/kanagawa.nvim" },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup()
    end,
  },
}
