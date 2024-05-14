-- Set lazy.nvim --
require("config.lazy")
-- Set colorscheme
require("everforest").load()
-- vim.cmd("colorscheme everforest")

-- Set nvim-tree
require("nvim-tree").setup()

-- Open nvim-tree on startup
local function open_nvim_tree()
    require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = open_nvim_tree
})

-- Enable mouse support
vim.opt.mouse = "nv"

-- Use system clipboard
-- vim.cmd("set clipboard+=unnamedplus")
--vim.opt.clipboard:append("unnamedplus")
vim.opt.clipboard = 'unnamedplus'
-- Indentation settings
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true

-- UI settings
-- vim.opt.showmode = true
-- vim.opt.showcmd = true
-- vim.opt.incsearch = true
-- vim.opt.hlsearch = true
-- vim.opt.ttyfast = true
-- vim.opt.lazyredraw = true
vim.opt.cursorline = true
-- vim.opt.wrapscan = true
