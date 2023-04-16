local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-S-u>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-S-i>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-S-o>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-S-p>", function() ui.nav_file(4) end)

require("harpoon").setup({
    menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
    }
})

