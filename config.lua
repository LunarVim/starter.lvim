lvim.log.level = "warn"
lvim.format_on_save = true
lvim.leader = "space"

-- uncomment the line below to disable icons
-- lvim.use_icons = false

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
