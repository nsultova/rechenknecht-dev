return {
    {
        'neanias/everforest-nvim',
        version = false,
        lazy = false,
        priority = 1000,
        config = function()
            require("everforest").setup({
                -- background = "soft"
            })
        end,
    },
    {
        'nvim-tree/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("nvim-web-devicons").setup()
            require("nvim-tree").setup({
            })
        end,
    }
}
