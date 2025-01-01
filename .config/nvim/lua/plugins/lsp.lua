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
                                "--header-insertion=never",
                                "--pch-storage=memory",
                            },
                            on_new_config = function(new_config, _)
                                local status, cmake = pcall(require, "cmake-tools")
                                if status then
                                    cmake.clangd_on_new_config(new_config)
                                end
                            end,
                        })
                    end,
                    ["zls"] = function()
                        vim.g.zig_fmt_parse_errors = 0
                        vim.g.zig_fmt_autosave = 0
                        require("lspconfig")["zls"].setup({
                            capabilities = capabilities,
                            settings = {
                                zls = {
                                    enable_build_on_save = true
                                }
                            }
                        })
                    end
                },
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {desc="lsp: Hover"})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {desc="lsp: Definition"})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {desc="lsp: References"})
            vim.keymap.set("n", "<leader>gf", vim.diagnostic.open_float, {desc="lsp: Open Float"})
            vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, {desc="lsp: Code Action"})
            vim.keymap.set("n", "<leader>grn", vim.lsp.buf.rename, {desc="lsp: Rename"})
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {desc="lsp: Rename"})

            -- fix rust_analyzer https://github.com/neovim/neovim/issues/30985#issuecomment-2447329525
            for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
                local default_diagnostic_handler = vim.lsp.handlers[method]
                vim.lsp.handlers[method] = function(err, result, context, config)
                    if err ~= nil and err.code == -32802 then
                        return
                    end
                    return default_diagnostic_handler(err, result, context, config)
                end
            end
        end,
    },
}
