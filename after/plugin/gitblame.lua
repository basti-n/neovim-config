local git_blame = require('gitblame')

vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>', {})
vim.keymap.set('n', '<leader>gbo', ':GitBlameOpenFileURL<CR>', {})
