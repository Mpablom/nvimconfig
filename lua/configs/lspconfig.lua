-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- Lista de servidores LSP (incluyendo PHP)
local servers = { "html", "cssls", "pyright", "intelephense" } -- <- Añadido intelephense

-- Configuración común para todos los LSP
local common_config = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- Configuración específica para intelephense (PHP/Laravel)
lspconfig.intelephense.setup(vim.tbl_deep_extend("force", common_config, {
  settings = {
    intelephense = {
      environment = {
        includePaths = { 
          "/usr/share/php",          -- Ruta estándar en Linux
          "vendor/laravel/framework" -- Para autocompletado de Laravel
        }
      },
      files = {
        maxSize = 5000000, -- Para proyectos grandes
      },
      diagnostics = {
        enable = true,
      },
      stubs = {  -- Stubs para Laravel y paquetes comunes
        "apache", "bcmath", "bz2", "calendar", "com", "core", 
        "curl", "date", "dba", "dom", "enchant", "exif", 
        "ffi", "fileinfo", "filter", "fpm", "ftp", "gd", 
        "gettext", "gmp", "hash", "iconv", "imap", "intl", 
        "json", "ldap", "mailparse", "mbstring", "meta", 
        "mysqli", "oci8", "odbc", "openssl", "pcntl", "pcre", 
        "pdo", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", 
        "phar", "posix", "pspell", "readline", "reflection", 
        "session", "shmop", "simplexml", "snmp", "soap", 
        "sockets", "sodium", "spl", "sqlite3", "standard", 
        "superglobals", "sysvmsg", "sysvsem", "sysvshm", 
        "tidy", "tokenizer", "xml", "xmlreader", "xmlwriter", 
        "xsl", "zip", "zlib", 
        "laravel", "phpunit" -- Stubs específicos
      }
    }
  },
  root_dir = function(fname)
    return lspconfig.util.root_pattern("composer.json", ".git")(fname) -- Detección de proyectos PHP
  end,
}))

-- Configurar el resto de servidores
for _, lsp in ipairs(servers) do
  if lsp ~= "intelephense" then  -- Evitar duplicar la configuración
    lspconfig[lsp].setup(common_config)
  end
end
