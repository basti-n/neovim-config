local map = vim.keymap.set
map({'n', 'v'}, '<leader>fix', ':TypescriptFixAll<CR>')
map({'n', 'v'}, '<leader>amp', ':TypescriptAddMissingImports<CR>')
map({'n', 'v'}, '<leader>rui', ':TypescriptRemoveUnused<CR>')

local autocmd = vim.api.nvim_create_autocmd
local Format = vim.api.nvim_create_augroup("Format", { clear = true })
autocmd("BufWritePre", {
	group = Format,
	pattern = "*.ts,*.tsx,*.jsx,*.js",
	callback = function()
		if vim.fn.exists(":TypescriptFixAll") then
			vim.cmd("TypescriptRemoveUnused!")
			vim.cmd("TypescriptAddMissingImports!")
			return nil
		end
		return {}
	end,
})
