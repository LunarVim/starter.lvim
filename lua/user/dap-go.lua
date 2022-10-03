local dap_go_ok, dap_go = pcall(require, "dap-go")
if not dap_go_ok then
  return
end

dap_go.setup()
