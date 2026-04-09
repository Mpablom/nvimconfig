return {
  -- Sintaxis Blade
  {
    "jwalton512/vim-blade",
    ft = "blade", -- Solo carga con archivos blade
  },

  -- Funcionalidad básica de Laravel
  {
    "noahfrederick/vim-laravel",
    ft = "php", -- Solo carga con archivos PHP
  },

  -- nvim-nio (necesario pero no problemático)
  {
    "nvim-neotest/nvim-nio",
    lazy = true,
  },

  -- Laravel.nvim - Solo cargar en proyectos Laravel
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "tpope/vim-dotenv",
      "kevinhwang91/promise-async",
      "nvim-nio/nvim-nio",
    },
    lazy = true, -- Carga perezosa
    -- Detectar si estamos en un proyecto Laravel
    cond = function()
      -- Verifica si existe archivo artisan en el directorio actual o superiores
      local function is_laravel_project()
        local cwd = vim.fn.getcwd()
        local artisan = vim.fn.findfile("artisan", cwd .. ";")
        return artisan ~= ""
      end
      return is_laravel_project()
    end,
    config = function()
      require("laravel").setup({
        commands = {
          routes = false,
          related = false,
        },
        route_info = {
          position = "bottom",
        },
        php_files_path = vim.fn.getcwd() .. "/.nvim-laravel",
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
