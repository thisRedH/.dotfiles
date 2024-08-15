return {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "https://codeberg.org/FelipeLema/cmp-async-path",
        --"hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-calc",
        "tamago324/cmp-zsh",
        { "L3MON4D3/LuaSnip", version = "2.*", build = "make install_jsregexp" },
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "folke/lazydev.nvim",

        "windwp/nvim-autopairs",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local cmp = require("cmp")
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview",
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm(),
                ["<Tab>"] = cmp.mapping.confirm(),
            }),
            sources = cmp.config.sources({
                { name = "lazydev", group_index = 0 },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "async_path" },
            }, {
                { name = "buffer" },
            }),
        })

        cmp.event:on(
            "confirm_done",
            require("nvim-autopairs.completion.cmp").on_confirm_done()
        )
    end,
}
