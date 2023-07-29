require("barbecue").setup({
    theme = { normal = { fg = "#74b1ca" } }
})

local bbq = require("barbecue.ui")

vim.keymap.set('n', '<leader>bq', function() bbq.toggle() end)
