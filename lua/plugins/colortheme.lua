-- Helper function to set colorscheme and transparent background
local function setTheme(theme)
  theme = theme or "rose-pine" -- Default theme
  vim.cmd.colorscheme(theme)

  -- Make normal and floating window backgrounds transparent
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Load theme AFTER plugins are ready
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Options: "tokyonight", "gruvbox", "rose-pine"
    setTheme("tokyonight")
  end,
})

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    config = function()
      require("tokyonight").setup({
        style = "storm",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          sidebars = "dark",
          floats = "dark",
        },
      })
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        bold = true,
        italic = { strings = false, comments = false, operators = false },
        strikethrough = true,
        inverse = true,
      })
    end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        disable_background = true,
        styles = { italic = false },
      })
    end,
  },
}
