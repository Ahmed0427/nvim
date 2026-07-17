vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>e", ":Explore<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("v", "<leader>p", '"_dP')

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.opt.termguicolors = true
vim.o.numberwidth = 5
vim.o.updatetime = 200
vim.o.timeoutlen = 500
vim.o.hlsearch = false
vim.o.splitbelow = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({ disable_background = true, styles = { italic = false } })
			vim.cmd.colorscheme("rose-pine")
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "Visual", { bg = "#403d52", fg = "NONE" })
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
		config = function()
			local o = { noremap = true, silent = true }
			vim.keymap.set("n", "<C-_>", require("Comment.api").toggle.linewise.current, o)
			vim.keymap.set("n", "<C-c>", require("Comment.api").toggle.linewise.current, o)
			vim.keymap.set("n", "<C-/>", require("Comment.api").toggle.linewise.current, o)
			vim.keymap.set(
				"v",
				"<C-_>",
				"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
				o
			)
			vim.keymap.set(
				"v",
				"<C-c>",
				"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
				o
			)
			vim.keymap.set(
				"v",
				"<C-/>",
				"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
				o
			)
		end,
	},
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},
	{ "folke/which-key.nvim" },
	{ "tpope/vim-sleuth" },
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<leader>hh", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)
			vim.keymap.set("n", "<leader>hn", function()
				harpoon:list():next()
			end)
			vim.keymap.set("n", "<leader>hp", function()
				harpoon:list():prev()
			end)

			vim.keymap.set("n", "<leader>1", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<leader>2", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<leader>3", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<leader>4", function()
				harpoon:list():select(4)
			end)
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		keys = {
			{
				"<leader>sf",
				function()
					require("telescope.builtin").find_files({ previewer = true })
				end,
			},
			{
				"<leader>sw",
				function()
					require("telescope.builtin").grep_string()
				end,
			},
			{
				"<leader>sg",
				function()
					require("telescope.builtin").live_grep()
				end,
			},
			{
				"<leader>/",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find(
						require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
					)
				end,
			},
		},
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					path_display = { "smart" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-l>"] = actions.select_default,
						},
					},
					file_ignore_patterns = { "node_modules", "target/", "%.git/", "%.venv", "build/", "%.class" },
				},
				pickers = {
					find_files = { hidden = true, no_ignore = true },
					live_grep = {
						additional_args = function()
							return { "--hidden", "--no-ignore" }
						end,
					},
				},
				extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown() } },
			})
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					pcall(function()
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end)
				end,
			})
		end,
		config = function()
			require("nvim-treesitter").setup({})
			require("nvim-treesitter").install({
				"lua",
				"java",
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
				"bash",
				"dockerfile",
				"terraform",
				"hcl",
				"toml",
				"rust",
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"goimports",
					"clang-format",
					"black",
					"prettier",
					"stylua",
					"shfmt",
					"shellcheck",
					"tflint",
				},
				auto_update = false,
				run_on_start = true,
				start_delay = 3000,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "goimports" },
					c = { "clang_format" },
					cpp = { "clang_format" },
					h = { "clang_format" },
					hpp = { "clang_format" },
					python = { "black" },
					html = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },
					markdown = { "prettier" },
					yaml = { "prettier" },
					sh = { "shfmt" },
					bash = { "shfmt" },
					terraform = { "terraform_fmt" },
					hcl = { "terraform_fmt" },
					rust = { "rustfmt" },
				},
				format_on_save = { lsp_fallback = false, timeout_ms = 500 },
			})
		end,
	},
})
