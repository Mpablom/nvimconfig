vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- Configuración global de diagnósticos
vim.diagnostic.config({
  virtual_text = {
    prefix = "■",
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Bootstrap Lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- Carga de plugins
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
}, require "configs.lazy")

-- Configuración del tema
require("tokyonight").setup({
  style = "night",
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
  },
})
vim.cmd [[colorscheme tokyonight-night]]

-- Configuración de plugins principales
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
    { name = "nvim_lsp" },
  },
})

require("neotest").setup({
  adapters = {
    require "neotest-java",
  },
})

-- Carga de configuraciones adicionales
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
