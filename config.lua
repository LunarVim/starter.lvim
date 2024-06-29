-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "lua",
  "rust",
  "toml",
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

vim.api.nvim_set_keymap("n", "<m-d>", "<cmd>RustOpenExternalDocs<Cr>", { noremap = true, silent = true })

lvim.builtin.which_key.mappings["C"] = {
  name = "Rust",
  r = { "<cmd>RustLsp runnables<Cr>", "Runnables" },
  t = { "<cmd>RustLsp testables<Cr>", "Testables" },
  e = { "<cmd>RustLsp expandMacro<Cr>", "Macro Expand" },
  h = { "<cmd>RustLsp hover actions<Cr>", "Hover" },
  M = { "<cmd>RustLsp rebuildProcMacros<Cr>", "Rebuild Macros" },
  g = { "<cmd>RustLsp codeAction<Cr>", "Code Action" },
  x = { "<cmd>RustLsp explainError<Cr>", "Explain Error" },
  d = { "<cmd>RustLsp renderDiagnostic<Cr>", "Diagnostic" },
  c = { "<cmd>RustLsp flyCheck<Cr>", "Check" },y = { "<cmd>lua require'crates'.open_repository()<cr>", "[crates] open repository" },
  P = { "<cmd>lua require'crates'.show_popup()<cr>", "[crates] show popup" },
  i = { "<cmd>lua require'crates'.show_crate_popup()<cr>", "[crates] show info" },
  f = { "<cmd>lua require'crates'.show_features_popup()<cr>", "[crates] show features" },
  D = { "<cmd>lua require'crates'.show_dependencies_popup()<cr>", "[crates] show dependencies" },
}

lvim.plugins = {
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    lazy = false,
  },
  {
    "saecki/crates.nvim",
    version = "v0.4.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          border = "rounded",
        },
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },
}
