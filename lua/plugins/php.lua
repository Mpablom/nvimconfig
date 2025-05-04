return {
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("laravel").setup()
      require("telescope").load_extension("laravel")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              environment = {
                includePaths = { "/usr/share/php8" },
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
    "jwalton512/vim-blade",
    ft = "blade",
  },
}
