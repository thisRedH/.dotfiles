return {
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "InsertEnter" },
        opts = {},
    }, {
        "Djancyp/better-comments.nvim",
        event = { "BufReadPre", "InsertEnter" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("better-comment").Setup() -- Why is this uppercase Djancyp?!
        end,
    }
}
