require("conform").setup({
    formatters_by_ft = {
        rust = { "rustfmt" },
        lua = { "stylua" },
        javascript = { { "prettierd" } },
        typescript = { "prettierd", "eslint_lsp" },
        html = { "prettierd", "eslint_lsp", "rustywind" },
        css = { "stylelint" },
        ["_"] = { "trim_whitespace" },
    },
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})

local function format()
    require("conform").format({ lsp_fallback = true, timeout = 2500 })
end

local function format_write()
    require("conform").format({
        timeout = 2500,
        lsp_fallback = true,
    }, vim.cmd.write)
end

local opts = { silent = true }
vim.keymap.set("n", "<leader>f", format, opts)
vim.keymap.set("n", "<leader>F", format_write, opts)

-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	group = vim.api.nvim_create_augroup("FormatAutogroup", {}),
-- 	callback = format_write,
-- })

-- null_ls.setup({
--     on_attach = function(client, bufnr)
--         if client.supports_method("textDocument/formatting") then
--             vim.keymap.set("n", "<leader>f", '<cmd>Prettier<CR>', { buffer = bufnr, desc = "[lsp] format" })
--
--             -- format on save
--             vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
--             vim.api.nvim_create_autocmd(event, {
--                 buffer = bufnr,
--                 group = group,
--                 callback = function()
--                     vim.cmd.Prettier()
--                 end,
--                 desc = "[lsp] format on save",
--             })
--         end
--
--         if client.supports_method("textDocument/rangeFormatting") then
--             vim.keymap.set("n", "<leader>f", '<cmd>Prettier<CR>', { buffer = bufnr, desc = "[lsp] format" })
--         end
--     end,
--     sources = {
--         null_ls.builtins.code_actions.refactoring,
--         null_ls.builtins.diagnostics.markdownlint,
--         null_ls.builtins.diagnostics.tsc,
--         null_ls.builtins.formatting.buf,
--         null_ls.builtins.formatting.prettier,
--     },
-- })
