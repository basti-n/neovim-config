vim.api.nvim_set_keymap('n', '<c-s>',
    "<cmd>lua require('fzf-lua').files()<CR>",
    { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<c-B>',
    "<cmd>lua require('fzf-lua').buffers()<CR>",
    { noremap = true, silent = true })


-- Telescope live grep is used for fuzzy search all files (also hidden ones)
-- vim.api.nvim_set_keymap('n', '<c-f>',
--     "<cmd>lua require('fzf-lua').grep_project()<CR>",
--     { noremap = true, silent = true })
