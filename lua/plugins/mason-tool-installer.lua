return {
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
            },
            auto_update = false,
            run_on_start = true,
            start_delay = 3000,
        })
    end,
}
