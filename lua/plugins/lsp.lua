return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mfussenegger/nvim-jdtls", -- Para Java
      "hrsh7th/cmp-nvim-lsp", -- Para autocompletado
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java", -- Solo carga para archivos Java
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
