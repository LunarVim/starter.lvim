local status_ok, dapgo = pcall(require, "dap-go")
if not status_ok then
  return
end

dapgo.setup()
