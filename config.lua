lvim.format_on_save = false
lvim.lsp.diagnostics.virtual_text = true

lvim.builtin.treesitter.highlight.enable = true

-- Auto install treesitter parsers.
lvim.builtin.treesitter.ensure_installed = { "latex" }

-- Setup Lsp.
local capabilities = require("lvim.lsp").common_capabilities()
require("lvim.lsp.manager").setup("texlab", {
  on_attach = require("lvim.lsp").common_on_attach,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = capabilities,
})

-- Setup formatters.
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "latexindent", filetypes = { "tex" } },
})

-- Set a linter.
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { command = "chktex", filetypes = { "tex" } },
})

-- UltiSnip configuration.
vim.cmd([[
  let g:UltiSnipsExpandTrigger="<CR>"
  let g:UltiSnipsJumpForwardTrigger="<Plug>(ultisnips_jump_forward)"
  let g:UltiSnipsJumpBackwardTrigger="<Plug>(ultisnips_jump_backward)"
  let g:UltiSnipsListSnippets="<c-x><c-s>"
  let g:UltiSnipsRemoveSelectModeMappings=0
  let g:UltiSnipsEditSplit="tabdo"
  let g:UltiSnipsSnippetDirectories=[$HOME."/.config/nvim/UltiSnips"]
]])

-- Vimtex configuration.
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_enabled = 0

-- Setup cmp.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("LaTeXGroup", { clear = true }),
  pattern = "tex",
  callback = function()
    require("user.cmp")
  end,
})

-- Mappings
lvim.builtin.which_key.mappings["C"] = {
  name = "LaTeX",
  m = { "<cmd>VimtexContextMenu<CR>", "Open Context Menu" },
  u = { "<cmd>VimtexCountLetters<CR>", "Count Letters" },
  w = { "<cmd>VimtexCountWords<CR>", "Count Words" },
  d = { "<cmd>VimtexDocPackage<CR>", "Open Doc for package" },
  e = { "<cmd>VimtexErrors<CR>", "Look at the errors" },
  s = { "<cmd>VimtexStatus<CR>", "Look at the status" },
  a = { "<cmd>VimtexToggleMain<CR>", "Toggle Main" },
  v = { "<cmd>VimtexView<CR>", "View pdf" },
  i = { "<cmd>VimtexInfo<CR>", "Vimtex Info" },
  l = {
    name = "Clean",
    l = { "<cmd>VimtexClean<CR>", "Clean Project" },
    c = { "<cmd>VimtexClean<CR>", "Clean Cache" },
  },
  c = {
    name = "Compile",
    c = { "<cmd>VimtexCompile<CR>", "Compile Project" },
    o = {
      "<cmd>VimtexCompileOutput<CR>",
      "Compile Project and Show Output",
    },
    s = { "<cmd>VimtexCompileSS<CR>", "Compile project super fast" },
    e = { "<cmd>VimtexCompileSelected<CR>", "Compile Selected" },
  },
  r = {
    name = "Reload",
    r = { "<cmd>VimtexReload<CR>", "Reload" },
    s = { "<cmd>VimtexReloadState<CR>", "Reload State" },
  },
  o = {
    name = "Stop",
    p = { "<cmd>VimtexStop<CR>", "Stop" },
    a = { "<cmd>VimtexStopAll<CR>", "Stop All" },
  },
  t = {
    name = "TOC",
    o = { "<cmd>VimtexTocOpen<CR>", "Open TOC" },
    t = { "<cmd>VimtexTocToggle<CR>", "Toggle TOC" },
  },
}

lvim.plugins = {
  "lervag/vimtex",
  "kdheepak/cmp-latex-symbols",
  "KeitaNakamura/tex-conceal.vim",
  "SirVer/ultisnips",
}
