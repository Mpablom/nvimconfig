return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local jdtls = require("jdtls")
      local std_data = vim.fn.stdpath("data")
      local mason_home = std_data .. "/mason"
      local jdtls_pkg = mason_home .. "/packages/jdtls"
      local home = vim.fn.expand("$HOME")

      local root_dir = require("jdtls.setup").find_root({
        ".git",
        "mvnw",
        "gradlew",
        "pom.xml",
        "build.gradle",
      }) or vim.loop.cwd()
      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

      local equinox_jar = vim.fn.glob(jdtls_pkg .. "/plugins/org.eclipse.equinox.launcher_*.jar", false, true)[1]
      if not equinox_jar then
        vim.notify("No se encontró el JAR de Equinox en " .. jdtls_pkg, vim.log.levels.ERROR)
        return
      end

      local lombok_jar = jdtls_pkg .. "/lombok.jar"
      if vim.fn.filereadable(lombok_jar) == 0 then
        vim.notify("lombok.jar no encontrado en: " .. lombok_jar, vim.log.levels.WARN)
      end

      local java_home = "/usr/lib/jvm/openjdk-bin-21"
      if vim.fn.isdirectory(java_home) == 0 then
        java_home = vim.fn.trim(vim.fn.system("dirname $(dirname $(readlink -f $(which java)))"))
      end

      local bundles = {}
      local debugger_jars = vim.fn.glob(
        mason_home .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
        1
      )
      if debugger_jars ~= "" then
        for _, jar in ipairs(vim.split(debugger_jars, "\n")) do
          table.insert(bundles, jar)
        end
      end

      local config = {
        cmd = {
          java_home .. "/bin/java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.level=ERROR",
          "-javaagent:" .. lombok_jar,
          "-Xms4g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          equinox_jar,
          "-configuration",
          jdtls_pkg .. "/config_linux",
          "-data",
          workspace_dir,
        },
        root_dir = root_dir,
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-21",
                  path = java_home,
                  default = true,
                },
              },
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            properties = {
              ["jdk.module.illegalAccess.silent"] = "true",
            },
          },
        },
        init_options = {
          bundles = bundles,
          extendedClientCapabilities = jdtls.extendedClientCapabilities,
        },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float, opts)

          jdtls.setup_dap({ hotcodereplace = "auto" })
          jdtls.setup.add_commands()
        end,
      }

      local ok, err = pcall(function()
        jdtls.start_or_attach(config)
        vim.notify("JDTLS iniciado para: " .. project_name, vim.log.levels.INFO)
      end)

      if not ok then
        vim.notify("ERROR al configurar JDTLS: " .. tostring(err), vim.log.levels.ERROR)
      end
    end,
  },
}
