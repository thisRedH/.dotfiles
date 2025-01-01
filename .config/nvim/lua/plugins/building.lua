return {
    {
        "Civitasv/cmake-tools.nvim",
        dependencies = {
            "stevearc/overseer.nvim",
            "akinsho/toggleterm.nvim",
            "mfussenegger/nvim-dap",
        },
        ft = { "c", "cpp", "cmake" },
        opts = {
            cmake_virtual_text_support = false,
        },
        init = function()
            local function debug()
                local cmake = require("cmake-tools")
                local dap = require("dap")
                if dap.session() == nil and cmake.is_cmake_project() then
                    cmake.debug({})
                else
                    dap.continue()
                end
            end

            vim.keymap.set("n", "<F5>", debug, {desc = "dbg: Continue debugging or start", remap = true})
            vim.keymap.set("n", "<leader>dc", debug, {desc = "dbg: Continue debugging or start", remap = true})
        end
    },
}
