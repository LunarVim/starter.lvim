local function setup_vim_test()
  vim.api.nvim_exec(
    [[
        " Test config
        let test#strategy = "neovim"
        let test#neovim#term_position = "belowright"
        let g:test#preserve_screen = 1
        let g:test#echo_command = 1
        " javascript
        " let g:test#javascript#runner = 'karma'
    ]],
    false
  )
end

lvim.plugins = {
  {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
  },
  -- neotest runners
  -- https://github.com/nvim-neotest/neotest#supported-runners
  { "nvim-neotest/neotest-python", },
  { "denmeade/neotest-jest" },

  --[[ For any runner without an adapter you can use neotest-vim-test
  which supports any runner that vim-test supports. The vim-test adapter
  does not support some of the more advanced features such as
  error locations or per-test output. --]]
  -- https://github.com/vim-test/vim-test/
  { "vim-test/vim-test", },
  { "nvim-neotest/neotest-vim-test" },
}

local test = require "neotest"
test.setup {
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      runner = "unittest",
    }),
    require('neotest-jest')({
      jestCommand = "npm test --"
    }),
    require("neotest-vim-test")({
      -- It is recommended to add any filetypes that are covered by another adapter to the ignore list
      ignore_file_types = { "python", "vim", "lua" },
    }),
    -- Or to only allow specified file types
    -- require("neotest-vim-test")({ allow_file_types = { "haskell", "elixir" } }),
  },
  setup_vim_test()
}

lvim.builtin.which_key.mappings["t"] = {
  name = "Test",
  a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
  f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
  F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
  l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
  L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
  n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
  N = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
  o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
  S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
  s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
}
