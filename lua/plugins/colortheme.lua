-- Helper function to set colorscheme and highlights
local function setTheme(theme)
  theme = theme or "rose-pine"
  vim.cmd.colorscheme(theme)

  -- Transparent backgrounds
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

  -- More visible Visual mode selection
  vim.api.nvim_set_hl(0, "Visual", {
    bg = "#403d52",
    fg = "NONE",
  })
end

-- Load theme AFTER plugins are ready
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    setTheme("rose-pine")
  end,
})

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        disable_background = true,
        styles = {
          italic = false,
        },
      })
    end,
  },
}
