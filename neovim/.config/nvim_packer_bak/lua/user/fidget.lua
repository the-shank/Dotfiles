local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
	print("failed: loading fidget")
	return
end

fidget.setup()
