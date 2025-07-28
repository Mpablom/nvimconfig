return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "php", "phpdoc" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" },
      },
    },
  },
}
