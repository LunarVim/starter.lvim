lvim.format_on_save = true

lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.autotag.enable = true

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

local clangd_capabilities = vim.deepcopy(capabilities)
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
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
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
-- codeactions
------------------------------------------------------------------------
local codeactions = require "lvim.lsp.null-ls.code_actions"
codeactions.setup {
  { name = "gitsigns" },
  { name = "refactoring" },
  { command = "eslint_d", filetype = { "javascript", "javascriptreact", "typescript", "typescriptreact" } },
}

------------------------------------------------------------------------
-- Plugins
------------------------------------------------------------------------
lvim.plugins = {

  -- utility plugins
  { "tpope/vim-surround", keys = { "c", "d", "y" } },

  -- search and replace
  "windwp/nvim-spectre",

  -- diagnostics with trouble.nvim
  "folke/trouble.nvim",

  -- auto close html tags
  "windwp/nvim-ts-autotag",

  {
    -- better UX with vim.ui.select and vim.ui.input
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup {
        input = {
          prefer_width = 55,
          prompt_align = "center",
          min_width = 30,
          relative = "editor",
        },
        select = {
          backend = { "telescope" },
          telescope = require("telescope.themes").get_dropdown { hide_preview = false },
        },
      }
    end,
  },

  {
    -- required for refactoring codeactions (caveat: only works with few common languages)
    -- view supported languages at https://github.com/ThePrimeagen/refactoring.nvim#supported-languages
    "ThePrimeagen/refactoring.nvim",
    config = function()
      require("refactoring").setup {
        -- prompt for return type
        prompt_func_return_type = {
          go = true,
          cpp = true,
          c = true,
          java = true,
        },
        -- prompt for function parameters
        prompt_func_param_type = {
          go = true,
          cpp = true,
          c = true,
          java = true,
        },
      }
    end,
  },
}

------------------------------------------------------------------------
-- custom which-key mappings
------------------------------------------------------------------------
lvim.builtin.which_key.vmappings["r"] = {
  name = "+refactor",
  r = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "refactor selection" },
}

lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["r"] = {
  name = "+Search and Replace",
  o = { "<cmd>lua require('spectre').open()<cr>", "open" },
  f = { "<cmd>lua require('spectre').open_file_search()<cr>", "file search" },
  c = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "search word under cursor" },
}
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  r = { "<cmd>Trouble lsp_references<cr>", "LSP References" },
  t = { "<cmd>Trouble lsp_type_definitions<cr>", "LSP Type definitions" },
}
