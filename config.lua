-- ===================================== General Section ============================================
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "tokyonight"
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.breadcrumbs.active = true


-- =================================== Treesitter Section ===========================================
lvim.builtin.treesitter.ensure_installed = {
  "go",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true


-- ======================================= LSP Section ==============================================
-- Will override the LSP formatting capabilities if any exist


-- ======================================= Dap Section ==============================================
lvim.builtin.dap.active = true

require("user.dapui")


-- ===================================== Plugins Section ============================================
lvim.plugins = {
  "rcarriga/nvim-dap-ui",
}


-- ================================= Go IDE Specific Section ========================================
local goide = require("user.goide")
goide.start()
