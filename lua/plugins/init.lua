return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
      local lspconfig = require "lspconfig"

      -- Angular
      lspconfig.angularls.setup {
        cmd = { "ngserver", "--stdio", "--tsProbeLocations", "./node_modules", "--ngProbeLocations", "./node_modules" },
        root_dir = lspconfig.util.root_pattern("angular.json", "project.json"),
        on_attach = function(client, bufnr) end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }

      -- TypeScript
      lspconfig.ts_ls.setup {
        on_attach = function(client, bufnr) end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }

      -- PHP/Laravel (Configuración mejorada)
      lspconfig.intelephense.setup {
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr, desc = "Formatear PHP" })
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Error anterior" })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Siguiente error" })
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          intelephense = {
            diagnostics = {
              enable = true,
              undefinedTypes = true,
              undefinedFunctions = true,
              undefinedConstants = true,
              undefinedVariables = true,
            },
            environment = {
              includePaths = {
                "/usr/share/php",
                "vendor/laravel/framework",
              },
            },
            files = {
              maxSize = 5000000,
            },
            stubs = {
              "apache", "bcmath", "core", "curl", "date", "dom",
              "fileinfo", "filter", "gd", "hash", "iconv", "intl",
              "json", "libxml", "mbstring", "mcrypt", "mysql", "mysqli",
              "password", "pcre", "PDO", "pdo_mysql", "Phar", "readline",
              "session", "SimpleXML", "sockets", "sodium", "standard",
              "superglobals", "tokenizer", "xml", "xmlreader", "xsl",
              "Zend OPcache", "zip", "zlib", "laravel", "phpunit",
            },
          },
        },
        root_dir = function(fname)
          return lspconfig.util.root_pattern("composer.json", ".git", "artisan")(fname)
            or lspconfig.util.path.dirname(fname)
        end,
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
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc", "html", "css",
        "typescript", "javascript", "python",
        "php", "phpdoc", "blade"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      require("cmp").setup {
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      }
    end,
  },

  {
    "adalessa/laravel.nvim",
    ft = "php",
    cond = function()
      return vim.fn.filereadable("artisan") == 1 or vim.fn.filereadable("composer.json") == 1
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "kevinhwang91/promise-async",
    },
    config = function()
      require("laravel").setup()
      pcall(require("telescope").load_extension, "laravel")
    end,
  },

  {
    "jwalton512/vim-blade",
    ft = "blade",
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup {
        sources = {
          require("null-ls").builtins.formatting.prettier,
          require("null-ls").builtins.diagnostics.eslint,
          require("null-ls").builtins.diagnostics.ruff,
        },
      }
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      require("dap").adapters.python = {
        type = "executable",
        command = os.getenv("HOME") .. "/.venvs/nvim/bin/python",
        args = { "-m", "debugpy.adapter" },
      }
      require("dap").configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function() return os.getenv("HOME") .. "/.venvs/nvim/bin/python" end,
        },
      }
    end,
  },
  {
  "ray-x/go.nvim",
  dependencies = {
    "mfussenegger/nvim-dap",
    "leoluz/nvim-dap-go",
    "rcarriga/nvim-dap-ui"
  },
  config = function()
    require("go").setup({
      goimport = "gopls",
      gofmt = "gofumpt",
      lsp_cfg = false, -- Usaremos nuestra propia config LSP
      dap_debug = true
    })
  end
},

{
  "leoluz/nvim-dap-go",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-go").setup()
  end
},

{
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dapui").setup({
      layouts = {
        {
          elements = { "repl", "breakpoints" },
          size = 40,
          position = "right"
        }
      }
    })
  end
},
}
