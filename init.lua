vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"
vim.cmd [[
  set background=dark
]]
-- load plugins
require("lazy").setup({
  {
    "williamboman/mason.nvim",
  },
  {
    "mfussenegger/nvim-jdtls",
    dependencies = "hrsh7th/cmp-nvim-lsp",
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "rcasia/neotest-java",
    },
  },
  { "nvim-neotest/nvim-nio" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
  },
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
require("tokyonight").setup({
  style = "night", -- Estilo del tema
  transparent = false, -- Opcional, desactiva el fondo transparente
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
  },
})
vim.cmd [[colorscheme tokyonight-night]]

require("mason").setup()
require("cmp").setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-c>"] = require("cmp").mapping.abort(),
    ["<CR>"] = require("cmp").mapping.confirm(),
    ["<C-n>"] = require("cmp").mapping.select_next_item(),
    ["<C-p>"] = require("cmp").mapping.select_prev_item(),
  },
  sources = {
    {
      name = "nvim_lsp",
    },
  },
})
require("neotest").setup({
  adapters = {
    require "neotest-java",
  },
})
-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

require("ibl").setup({})

