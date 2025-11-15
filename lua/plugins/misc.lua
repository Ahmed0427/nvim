-- Standalone plugins with less than 10 lines of config go here
return {
  {
    "mbbill/undotree",

    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },
  {
    -- Hints keybinds
    "folke/which-key.nvim",
  },
  {
    -- Automatically detects tabstop/shiftwidth
    "tpope/vim-sleuth",
  },
}
