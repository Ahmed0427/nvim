return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local mark = require('harpoon.mark')
    local ui = require('harpoon.ui')

    -- Keybindings
    vim.keymap.set('n', '<leader>ha', mark.add_file, { desc = "Add file to Harpoon" })
    vim.keymap.set('n', '<leader>hh', ui.toggle_quick_menu, { desc = "Toggle Harpoon Menu" })
    vim.keymap.set('n', '<leader>hn', ui.nav_next, { desc = "Next Harpoon File" })
    vim.keymap.set('n', '<leader>hp', ui.nav_prev, { desc = "Previous Harpoon File" })

    -- Quick file navigation
    vim.keymap.set('n', '<leader>1', function() ui.nav_file(1) end, { desc = "Go to Harpoon File 1" })
    vim.keymap.set('n', '<leader>2', function() ui.nav_file(2) end, { desc = "Go to Harpoon File 2" })
    vim.keymap.set('n', '<leader>3', function() ui.nav_file(3) end, { desc = "Go to Harpoon File 3" })
    vim.keymap.set('n', '<leader>4', function() ui.nav_file(4) end, { desc = "Go to Harpoon File 4" })
  end,
}
