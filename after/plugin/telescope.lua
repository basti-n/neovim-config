local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
    defaults = {
        -- `hidden = true` is not supported in text grep commands.
        hidden = true,
        vimgrep_arguments = vimgrep_arguments,
    },
    pickers = {
        find_files= {
            hidden = true,
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
     },
})

require("telescope").setup {
    defaults = {
        path_display = { "truncate" },
    },
    pickers = {
        live_grep = {
            additional_args = function(opts)
                return {"--hidden"}
            end,
        },
        defaults = {
            file_ignore_patterns = {
                "node_modules/.*",
                ".git/.*"
            },
        }
    },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
vim.keymap.set('n', '<leader>gcl', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gbl', builtin.git_branches, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<leader>s', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>of', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- LSP 
vim.keymap.set('n', '<leader>dw', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>df', ':Telescope diagnostics bufnr=0<CR>', {})
