return {
    {
        "neovim/nvim-lspconfig",
        config = false,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "VeryLazy" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            local capabilities = vim.tbl_deep_extend(
                "force", {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "rust_analyzer",
                    "gopls",
                },
                handlers = {
                    function(server_name) -- default handler
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities
                        })
                    end,
                    ["lua_ls"] = function()
                        require("lspconfig")["lua_ls"].setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = { version = { "LuaJIT" } },
                                }
                            }
                        })
                    end,
                    ["clangd"] = function()
                        require("lspconfig")["clangd"].setup({
                            capabilities = capabilities,
                            cmd = {
                                "clangd",
                                "--background-index",
                                "-j=12",
                                "--all-scopes-completion",
                                "--completion-style=detailed",
                                "--header-insertion-decorators",
                                "--header-insertion=iwyu",
                                "--pch-storage=memory",
                            },
                            on_new_config = function(new_config, _)
                                local status, cmake = pcall(require, "cmake-tools")
                                if status then
                                    cmake.clangd_on_new_config(new_config)
                                end
                            end,
                        })
                    end
                },
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
        end,
    },
}
