local dap_status_ok, rt = pcall(require, "rust-tools")
if not dap_status_ok then
	print("rust-tools: failed to load")
	return
end

require("rust-tools").setup()
