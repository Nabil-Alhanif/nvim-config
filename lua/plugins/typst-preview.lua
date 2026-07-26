local M = {}

function M.setup()
	local status_ok, typst_preview = pcall(require, "typst-preview")
	if not status_ok then
		return
	end

	typst_preview.setup()
end

return M
