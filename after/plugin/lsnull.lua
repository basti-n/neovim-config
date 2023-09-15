local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        callback = function()
            vim.cmd.Prettier()
        end,
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

null_ls.setup({
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<leader>f", '<cmd>Prettier<CR>', { buffer = bufnr, desc = "[lsp] format" })

            -- format on save
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
            vim.api.nvim_create_autocmd(event, {
                buffer = bufnr,
                group = group,
                callback = function()
                    lsp_formatting(bufnr)
                end,
                desc = "[lsp] format on save",
            })
        end

        if client.supports_method("textDocument/rangeFormatting") then
            vim.keymap.set("n", "<leader>f", '<cmd>Prettier<CR>', { buffer = bufnr, desc = "[lsp] format" })
        end
    end,
    sources = {
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.tsc,
        null_ls.builtins.formatting.buf,
        null_ls.builtins.formatting.prettier,
    },
})
