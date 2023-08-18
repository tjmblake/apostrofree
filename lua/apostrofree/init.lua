local M = {}
M.namespace = vim.api.nvim_create_namespace('apostrofree')
M._diagnostic_message = "Free thee apostrofree!"

vim.diagnostic.config({
	["apostrofree"] = {
		log_level = vim.log.levels.INFO
	},
	virtual_text = true
})

M.free_thee_apostrofree = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local text = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	for line_number, line in ipairs(text) do
		if line:match("’") then
			local newStr = line:gsub('’', "'")
			vim.api.nvim_buf_set_lines(bufnr, line_number - 1, line_number, false, { newStr })
		end
	end
end

M.see_thee_apostrofree = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local text = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	local diagnostics = {}

	for line_number, line in ipairs(text) do
		for col_start, col_end in line:gmatch("()’()") do
			local diagnostic = {
				lnum = line_number - 1,
				end_lnum = line_number - 1,
				col = col_start - 1,
				end_col = col_end - 1,
				severity = vim.diagnostic.severity.ERROR,
				message = M._diagnostic_message,
			}
			table.insert(diagnostics, diagnostic)
		end
	end

	vim.diagnostic.set(M.namespace, bufnr, diagnostics)
end

-- Default Bindings
vim.keymap.set('n', '<Leader>apos', function() M.free_thee_apostrofree() end)

return M
