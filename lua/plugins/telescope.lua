return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
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
  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        -- Path display makes it easier to read deep Java paths
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-l>"] = actions.select_default,
          },
        },
        -- Ignore heavy binaries but keep the search deep
        file_ignore_patterns = {
          "node_modules",
          "target/",
          "%.git/",
          "%.venv",
          "build/",
          "%.class",
        },
      },
      pickers = {
        find_files = {
          -- This is the "fix": hidden shows dotfiles,
          -- no_ignore shows files even if not 'git added' yet
          hidden = true,
          no_ignore = true,
        },
        live_grep = {
          additional_args = function(_)
            return { "--hidden", "--no-ignore" }
          end,
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- Enable extensions
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- Keymaps
    local builtin = require("telescope.builtin")
    vim.keymap.set(
      "n",
      "<leader>sh",
      builtin.help_tags,
      { desc = "[S]earch [H]elp" }
    )
    vim.keymap.set(
      "n",
      "<leader>sk",
      builtin.keymaps,
      { desc = "[S]earch [K]eymaps" }
    )

    -- Optimized File Search
    vim.keymap.set("n", "<leader>sf", function()
      builtin.find_files({ previewer = true })
    end, { desc = "[S]earch [F]iles" })

    vim.keymap.set(
      "n",
      "<leader>ss",
      builtin.builtin,
      { desc = "[S]earch [S]elect Telescope" }
    )
    vim.keymap.set(
      "n",
      "<leader>sw",
      builtin.grep_string,
      { desc = "[S]earch current [W]ord" }
    )
    vim.keymap.set(
      "n",
      "<leader>sg",
      builtin.live_grep,
      { desc = "[S]earch by [G]rep" }
    )
    vim.keymap.set(
      "n",
      "<leader>sd",
      builtin.diagnostics,
      { desc = "[S]earch [D]iagnostics" }
    )
    vim.keymap.set(
      "n",
      "<leader>sr",
      builtin.resume,
      { desc = "[S]earch [R]esume" }
    )
    vim.keymap.set(
      "n",
      "<leader>s.",
      builtin.oldfiles,
      { desc = "[S]earch Recent Files" }
    )
    vim.keymap.set(
      "n",
      "<leader><leader>",
      builtin.buffers,
      { desc = "[ ] Find existing buffers" }
    )

    -- Current buffer fuzzy search
    vim.keymap.set("n", "<leader>/", function()
      builtin.current_buffer_fuzzy_find(
        require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        })
      )
    end, { desc = "[/] Fuzzily search in current buffer" })
  end,
}
