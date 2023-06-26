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
  "lua_ls",
  "cssls",
  "tsserver",
  "tailwindcss",
  "elixirls"
}

-- Additional Plugins
lvim.plugins = {
}


vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tailwindcss" })
local opts = {
  root_dir = function(fname)
    local util = require "lspconfig/util"
    return util.root_pattern("assets/tailwind.config.js", "tailwind.config.js", "tailwind.config.cjs", "tailwind.js",
      "tailwind.cjs")(fname)
  end,
  init_options = {
    userLanguages = { heex = "html", elixir = "html" }
  },
}
require("lvim.lsp.manager").setup("tailwindcss", opts)
