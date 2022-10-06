-- ===================================== General Section ============================================
lvim.log.level = "warn"
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
lvim.builtin.treesitter.highlight.enable = true


-- ======================================= Dap Section ==============================================
lvim.builtin.dap.active = true


-- ===================================== Plugins Section ============================================
lvim.plugins = {}


-- ================================= Go IDE Specific Section ========================================
GOIDE_CONFIG = {
  use_simple = true,
  format_on_save = false
}

lvim.format_on_save = false
local goide = require("user.goide_simple")
if not GOIDE_CONFIG.use_simple then
  goide = require("user.goide_complex")
end

goide.start()
