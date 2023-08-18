describe("apostrofree.setup", function()
	before_each(function()
	end)

	it("can be setup", function()
		require("apostrofree")
	end)

	it("sets default binding", function()
		-- Check existing keybind / reset
		vim.keymap.set('n', '<Leader>apos', 'do nothing')
		local maps = vim.api.nvim_get_keymap('n')

		local apos = {}
		for _, map in ipairs(maps) do
			if map.lhs == ' apos' then
				apos = map
			end
		end

		assert(apos.rhs == 'do nothing')

		-- Require apostrofree
		require('apostrofree')

		-- Check Bind Set
		maps = vim.api.nvim_get_keymap('n')

		apos = {}
		for _, map in ipairs(maps) do
			if map.lhs == '<Leader>apos' then
				apos = map
			end
		end

		assert(apos.rhs ~= 'do nothing')
	end)
end)

describe("apostrofree.see_thee_apostrofree", function()
	it('displays diagnostics on invalid apostrophe', function()
		local bufnr = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {"This is a ’ checker"})
		vim.api.nvim_set_current_buf(bufnr)	

		local plugin = require('apostrofree')
		plugin.see_thee_apostrofree()

		local diagnostics = vim.diagnostic.get(bufnr)

		local match = {}

		for _, diagnostic in ipairs(diagnostics) do
			if diagnostic.message == plugin._diagnostic_message then
				match = diagnostic
			end
		end

		assert(match.message == plugin._diagnostic_message) 
	end)
end)

describe("apostrofree.free_thee_apostrofree", function()
	it('displays diagnostics on invalid apostrophe', function()
		local bufnr = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {"This is a ’ checker"})
		vim.api.nvim_set_current_buf(bufnr)	

		local plugin = require('apostrofree')
		plugin.free_thee_apostrofree()

		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)

		local match = {}

		for _, line in ipairs(lines) do
			assert(line == "This is a ' checker")
		end
	end)
end)
