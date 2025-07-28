return {
  -- Sintaxis Blade
  {
    "jwalton512/vim-blade",
    config = function()
      vim.g.blade_custom_directives = {
        "auth",
        "can",
        "cannot",
        "production",
        "env",
        "inject",
        "push",
        "prepend",
        "stack",
        "vite",
        "once",
      }
      vim.g.blade_custom_directives_pairs = {
        { "custom", "endcustom" },
        { "push", "endpush" },
        { "verbatim", "endverbatim" },
      }
    end,
  },

  -- Funcionalidad básica de Laravel
  {
    "noahfrederick/vim-laravel",
    config = function()
      vim.g.laravel_artisan_command = "php artisan"
    end,
  },

  -- Laravel.nvim (sin integración problemática con Telescope)
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "tpope/vim-dotenv",
      "kevinhwang91/promise-async",
    },
    config = function()
      require("laravel").setup({
        commands = {
          routes = false, -- Desactivamos la integración con Telescope
          related = false, -- Desactivamos la integración con Telescope
        },
        route_info = {
          position = "bottom",
        },
      })
    end,
  },

  -- Navegación entre componentes
  {
    "tpope/vim-projectionist",
    init = function()
      vim.g.projectionist_heuristics = {
        ["*"] = {
          ["app/*.php"] = { type = "class" },
          ["app/Models/*.php"] = { type = "model" },
          ["app/Http/Controllers/*.php"] = { type = "controller" },
          ["resources/views/*.blade.php"] = { type = "view" },
          ["routes/*.php"] = { type = "route" },
          ["tests/*Test.php"] = { type = "test" },
        },
      }
    end,
  },
}
