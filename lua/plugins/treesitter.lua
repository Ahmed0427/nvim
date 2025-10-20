return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"python",
				"go",
				"c",
				"cpp",
				"html",
				"css",
				"javascript",
				"typescript",
				"json",
				"markdown",
				"yaml",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
