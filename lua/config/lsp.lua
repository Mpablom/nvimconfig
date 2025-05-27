local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Configuración común para todos los LSP
local common_config = {
  capabilities = capabilities,
}

-- Configuración específica para cada lenguaje
local servers = {
  -- HTML
  html = {},

  -- CSS
  cssls = {},

  -- Python
  pyright = {},

  -- Go
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
        gofumpt = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          functionTypeParameters = true,
        },
      },
    },
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern("go.work", "go.mod", ".git")(fname)
    end,
  },

  -- TypeScript
  tsserver = {},

  -- Angular
  angularls = {
    cmd = { "ngserver", "--stdio", "--tsProbeLocations", "./node_modules", "--ngProbeLocations", "./node_modules" },
    root_dir = require("lspconfig.util").root_pattern("angular.json", "project.json"),
  },

  -- PHP/Laravel
  intelephense = {
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
          "apache",
          "bcmath",
          "core",
          "curl",
          "date",
          "dom",
          "fileinfo",
          "filter",
          "gd",
          "hash",
          "iconv",
          "intl",
          "json",
          "libxml",
          "mbstring",
          "mcrypt",
          "mysql",
          "mysqli",
          "password",
          "pcre",
          "PDO",
          "pdo_mysql",
          "Phar",
          "readline",
          "session",
          "SimpleXML",
          "sockets",
          "sodium",
          "standard",
          "superglobals",
          "tokenizer",
          "xml",
          "xmlreader",
          "xsl",
          "Zend OPcache",
          "zip",
          "zlib",
          "laravel",
          "phpunit",
        },
      },
    },
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern("composer.json", ".git", "artisan")(fname)
        or require("lspconfig.util").path.dirname(fname)
    end,
  },
}

-- Configurar cada servidor LSP
require("lazyvim.util").on_attach(function(client, bufnr)
  -- Atajos comunes para todos los LSP
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
end)

for server, config in pairs(servers) do
  require("lspconfig")[server].setup(vim.tbl_deep_extend("force", common_config, config))
end
