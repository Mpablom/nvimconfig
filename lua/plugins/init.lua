return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
      local lspconfig = require "lspconfig"
      lspconfig.angularls.setup {
        cmd = { "ngserver", "--stdio", "--tsProbeLocations", "./node_modules", "--ngProbeLocations", "./node_modules" },
        root_dir = lspconfig.util.root_pattern("angular.json", "project.json"),
        on_attach = function(client, bufnr) end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }

      lspconfig.ts_ls.setup {
        on_attach = function(client, bufnr) end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      on_colors = function(colors) end,
      on_highlights = function(highlights, colors) end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd [[colorscheme tokyonight-night]]
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "typescript",
        "javascript",
        "python",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require "cmp"
      cmp.setup {
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      }
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require "null-ls"
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.diagnostics.ruff,
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      dap.adapters.python = {
        type = "executable",
        command = os.getenv "HOME" .. "/.venvs/nvim/bin/python",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return os.getenv "HOME" .. "/.venvs/nvim/bin/python"
          end,
        },
      }
    end,
  },
  
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
