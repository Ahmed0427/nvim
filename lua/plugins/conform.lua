return {
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
            },
            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 500,
            },
        })
    end,
}
