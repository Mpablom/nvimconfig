return {
  { "williamboman/mason.nvim", version = "1.11.0" },
  { "williamboman/mason-lspconfig.nvim", version = "1.32.0" },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "lua-language-server",
          "pyright",
          "bash-language-server",
          "stylua",
        },
        auto_update = true,
        run_on_start = true,
      })
    end,
  },
}
