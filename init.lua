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
					file_ignore_patterns = { "%.git/" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-l>"] = actions.select_default,
						},
					},
				},
				pickers = {
					find_files = { hidden = true },
					live_grep = {
						additional_args = function()
							return { "--hidden" }
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
			require("nvim-treesitter").install({})
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
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"rust_analyzer",
					"pyright",
					"ruff",
					"clangd",
					"ts_ls",
					"html",
					"cssls",
					"jsonls",
					"yamlls",
					"bashls",
					"dockerls",
					"terraformls",
				},
			})

			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = true },
				virtual_text = { source = false },
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf }
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
					end

					map("n", "gd", vim.lsp.buf.definition, "Goto definition")
					map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
					map("n", "gi", vim.lsp.buf.implementation, "Goto implementation")
					map("n", "gy", vim.lsp.buf.type_definition, "Goto type definition")
					map("n", "gr", vim.lsp.buf.references, "References")
					map("n", "K", vim.lsp.buf.hover, "Hover")
					map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>D", vim.diagnostic.open_float, "Line diagnostics")
					map("n", "<leader>wd", vim.diagnostic.setqflist, "Diagnostics to quickfix")
					map("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "Prev diagnostic")
					map("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "Next diagnostic")
					map("n", "<leader>lf", function()
						vim.lsp.buf.format({ bufnr = event.buf, timeout_ms = 1000 })
					end, "Format buffer")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method("textDocument/formatting") then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = event.buf,
							group = vim.api.nvim_create_augroup("lsp-format-" .. event.buf, { clear = true }),
							callback = function()
								vim.lsp.buf.format({ bufnr = event.buf, timeout_ms = 1000 })
							end,
						})
					end
				end,
			})
		end,
	},
})
