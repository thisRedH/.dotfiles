return {
    {
        "williamboman/mason.nvim",
        event = { "VeryLazy" },
        opts = {},
    },
    {
        "mfussenegger/nvim-dap",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim" },
        config = false,
        init = function()
            local dap = require("dap")
            local function mapn(k, f, d)
                vim.keymap.set("n", k, f, {desc = d})
            end

            mapn("<F4>", dap.terminate, "dbg: Terminate debugging")
            mapn("<F5>", dap.continue, "dbg: Continue debugging or start")
            mapn("<F6>", dap.step_into, "dbg: Step into")
            mapn("<F7>", dap.step_over, "dbg: Step over")
            mapn("<F8>", dap.step_out, "dbg: Step out")
            mapn("<F9>", dap.step_back, "dbg: Step back")

            mapn("<leader>dr", dap.restart, "dbg: Restart")
            mapn("<leader>dt", dap.terminate, "dbg: Terminate debugging")
            mapn("<leader>dc", dap.continue, "dbg: Continue debugging or start")
            mapn("<leader>di", dap.step_into, "dbg: Step into")
            mapn("<leader>dn", dap.step_over, "dbg: Step over")
            mapn("<leader>do", dap.step_out, "dbg: Step out")
            mapn("<leader>dp", dap.step_back, "dbg: Step back")

            mapn("<leader>b", dap.toggle_breakpoint, "dbg: Toggle breakpoint")
            mapn("<leader>db", dap.toggle_breakpoint, "dbg: Toggle breakpoint")
            mapn("<leader>dB", function() dap.toggle_breakpoint(vim.fn.input("Breakpoint condition: ")) end, "dbg: Toggle conditional breakpoint")
            mapn("<leader>dl", function() dap.toggle_breakpoint(nil, nil, vim.fn.input("Breakpoint message: ")) end, "dbg: Toggle breakpoint with log message")
        end
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            ensure_installed = {
                "codelldb",
            },
            handlers = {
                function(config) -- default handler
                    require("mason-nvim-dap").default_setup(config)
                end,
            },
        },
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "mfussenegger/nvim-dap",
        },
        opts = {
            virt_text_pos = "eol",
            highlight_changed_variables = true,
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap",
        },
        opts = {
            layouts = {{
                elements = {{
                    id = "scopes",
                    size = 0.25
                }, {
                    id = "breakpoints",
                    size = 0.25
                }, {
                    id = "stacks",
                    size = 0.25
                }, {
                    id = "watches",
                    size = 0.25
                } },
                position = "right",
                size = 40
            }, {
                elements = { {
                    id = "repl",
                    size = 0.5
                }, {
                    id = "console",
                    size = 0.5
                } },
                position = "bottom",
                size = 10
            }},
        },
        init = function ()
            local dap, dapui = require("dap"), require("dapui")

            vim.api.nvim_create_user_command("DapuiOpen", dapui.open, {})
            vim.api.nvim_create_user_command("DapuiClose", dapui.close, {})

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end
    },
}
