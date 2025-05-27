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

      -- Root del proyecto y directorio de workspace único
      local root_dir = require("jdtls.setup").find_root({
        ".git",
        "mvnw",
        "gradlew",
        "pom.xml",
        "build.gradle",
      }) or vim.loop.cwd()
      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

      -- Localiza el launcher JAR de Eclipse Equinox
      local equinox_jar = vim.fn.glob(jdtls_pkg .. "/plugins/org.eclipse.equinox.launcher_*.jar", true)

      -- Paths
      local config_dir = jdtls_pkg .. "/config_linux"
      local lombok_jar = jdtls_pkg .. "/lombok.jar"
      local java_home = "/usr/lib/jvm/openjdk-bin-21" -- tu JDK‑21

      -- Bundles para java-debug
      local bundles = {}
      for _, jar in
        ipairs(
          vim.split(
            vim.fn.glob(
              mason_home .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
              1
            ),
            "\n",
            true
          )
        )
      do
        if jar ~= "" then
          table.insert(bundles, jar)
        end
      end

      -- Configuración de JDTLS
      local config = {
        cmd = {
          -- Invocamos directamente Java sobre el launcher JAR
          java_home .. "/bin/java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          equinox_jar,
          "-configuration",
          config_dir,
          "-data",
          workspace_dir,
          ("-javaagent:%s"):format(lombok_jar),
        },
        root_dir = root_dir,
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-21",
                  path = java_home,
                },
              },
            },
          },
        },
        init_options = {
          bundles = bundles,
        },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = function(client, bufnr)
          local function buf_map(mode, lhs, rhs)
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
          end
          buf_map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
          buf_map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
          buf_map("n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>")
        end,
      }

      -- Auto-arranque al abrir un buffer Java
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          jdtls.start_or_attach(config)
        end,
      })
    end,
  },
}
