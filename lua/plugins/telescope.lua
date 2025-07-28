return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Requerido
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Opcional pero recomendado
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = {
            "vendor/",
            "node_modules/",
            "%.blade.php",
          },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = false,
          },
          live_grep = {
            additional_args = function(opts)
              return { "--hidden" }
            end,
          },
        },
      })

      -- Cargar extensión fzf si está instalada
      pcall(telescope.load_extension, "fzf")

      -- Atajos clave básicos
      local map = vim.keymap.set
      map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
      map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
      map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
      map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })

      -- Atajos específicos para Laravel (sin necesidad de la extensión laravel)
      map("n", "<leader>flc", "<cmd>Telescope find_files cwd=app/Http/Controllers<cr>", { desc = "Find Controllers" })
      map("n", "<leader>flv", "<cmd>Telescope find_files cwd=resources/views<cr>", { desc = "Find Views" })
      map("n", "<leader>flr", function()
        require("telescope.builtin").live_grep({ search_dirs = { "routes" } })
      end, { desc = "Search Routes" })
    end,
  },
}
