return {
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "kevinhwang91/promise-async",
    },
    config = function()
      require("laravel").setup({
        commands = {
          routes = false,
          related = false,
        },
      })
    end,
  },
  {
    "phpactor/phpactor",
    ft = "php",
    build = "composer install --no-dev --optimize-autoloader",
    config = function() end,
  },
}
