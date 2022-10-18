------------------------
-- Language Key Mappings
------------------------
lvim.builtin.which_key.mappings["C"] = {
  name = "Go",
  i = { "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies" },
  t = { "<cmd>GoMod tidy<cr>", "Tidy" },
  a = { "<cmd>GoTestAdd<Cr>", "Add Test" },
  A = { "<cmd>GoTestsAll<Cr>", "Add All Tests" },
  e = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
  g = { "<cmd>GoGenerate<Cr>", "Go Generate" },
  f = { "<cmd>GoGenerate %<Cr>", "Go Generate File" },
  c = { "<cmd>GoCmt<Cr>", "Generate Comment" },
  r = { "<cmd>GoIfErr<Cr>", "Add if err" },
}
lvim.builtin.which_key.mappings["dT"] = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test" }
