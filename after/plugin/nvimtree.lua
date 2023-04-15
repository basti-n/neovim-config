local nvim_tree = require("nvim-tree")

-- disable netrw at the very start of your init.lua (strongly advised)
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
nvim_tree.setup({
    sort_by = "case_sensitive",
    view = {
        width = 40,
        mappings = {
            list = {
                key = "u", action = "dir_up" }
        }
    },
    renderer = {
        group_empty = true,
    },
    filters = {
       --  dotfiles = true,
    },
})

vim.keymap.set('n', '<leader>ex', ':NvimTreeToggle<CR>', {
    noremap = true
})
vim.keymap.set('n', '<leader>ef', ':NvimTreeFindFileToggle<CR>', {
    noremap = true
})
vim.keymap.set('n', '<leader>ff', ':NvimTreeFindFile<CR>', {
    noremap = true
})
vim.keymap.set('n', '<leader>fx', ':NvimTreeFocus<CR>', {
    noremap = true
})

vim.keymap.set('n', '<leader>fs+', ':NvimTreeResize +20<CR>', {
    noremap = true
})
vim.keymap.set('n', '<leader>fs-', ':NvimTreeResize -20<CR>', {
    noremap = true
})
vim.keymap.set('n', '<leader>fsb', ':NvimTreeResize 40<CR>', {
    noremap = true
})
