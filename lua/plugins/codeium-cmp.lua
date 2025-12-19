-- Archivo: ~/.config/nvim/lua/plugins/codeium-cmp.lua
-- Integración de Codeium con nvim-cmp

return {
  {
    "jcdickinson/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        config_path = vim.fn.stdpath("config") .. "/codeium.json",
      })
    end,
  },
}
