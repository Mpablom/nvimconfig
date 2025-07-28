return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              environment = {
                includePaths = { "vendor/laravel/framework/src", "vendor/livewire/livewire/src" },
              },
              diagnostics = {
                undefinedTypes = true,
                undefinedFunctions = true,
                undefinedConstants = true,
                undefinedClassConstants = true,
              },
              stubs = {
                "laravel",
                "livewire",
              },
              files = {
                maxSize = 5000000,
              },
            },
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  { import = "plugins.java" },
}
