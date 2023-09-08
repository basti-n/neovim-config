local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'angularls'
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local util = require('lspconfig.util')
local root_dir = util.root_pattern('nx.json', 'package.json')
require'lspconfig'.angularls.setup{
  root_dir = root_dir
}
require'lspconfig'.eslint.setup{
    root_dir = root_dir,
    flags = { debounce_text_changes = 500 },
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = true
        if client.server_capabilities.document_formatting then
            local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function()
                    vim.lsp.buf.formatting_sync()
                end,
                group = au_lsp,
            })
        end
    end,
}
require("typescript").setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
    },
    server = { -- pass options to lspconfig's setup method
    root_dir = root_dir
},
})
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  -- show suggestion before typing
  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete({}), { 'i', 'c' }),

  ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-e>"] = cmp.mapping.abort(),
})

local lspkind = require('lspkind')
lspkind.init({
    preset = 'codicons',
})
local formatting  = {
    format = lspkind.cmp_format {
        with_text = true,
        menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            path = "[path]",
            luasnip = "[snip]",
            gh_issues = "[issues]",
        },
        mode = 'symbol_text',
    },
}

local sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'buffer' },
}

local snippet = {
    expand = function(args)
        require 'luasnip'.lsp_expand(args.body)
    end
}

local experimental = {
    native_menu = false,
    ghost_text = false,
}

vim.api.nvim_set_hl(0, "LualineYellow", { bg = "#b5bd68", fg = "#000000", bold = true  })
vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#9ccfd8"})
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#c3a7e7"})
local window = {
    completion = cmp.config.window.bordered({
        winhighlight = 'Normal:PmenuSel,FloatBorder:PmenuSel,CursorLine:LualineYellow,Search:None'
    }),
    documentation = cmp.config.window.bordered({
        winhighlight = 'Normal:PmenuSel,FloatBorder:PmenuSel,CursorLine:LualineYellow,Search:None'
    })
}
cmp.setup({
    window = window
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    sources = sources,
    snippet = snippet,
    formatting = formatting,
    experimental = experimental,
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  -- Replaced with Telescope
  -- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})


-- language specific nvim-cmp
cmp.setup.filetype('markdown', {
    sources = cmp.config.sources {
        {
            name = 'look',
            keyword_length = 2,
            option = {
                convert_case = true,
                loud = true
                --dict = '/usr/share/dict/words'
            }
        }}
    })
