-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.g.copilot_node_command = "node"
vim.g.copilot_filetypes = { ["*"] = true }
