return {
  {
    "github/copilot.vim",
    lazy = false, -- Carga inmediatamente al iniciar Neovim
    config = function()
      -- Configuración básica (opcional)
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""

      -- Atajos de teclado personalizados
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', {
        silent = true,
        expr = true,
        script = true,
        replace_keycodes = false,
      })
      vim.keymap.set("i", "<C-N>", "<Plug>(copilot-next)")
      vim.keymap.set("i", "<C-T>", "<Plug>(copilot-previous)")
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "nvim-cmp",
    config = function()
      require("copilot_cmp").setup({
        formatters = {
          insert_text = function(text)
            return text:gsub("\n", " ")
          end,
        },
      })
    end,
  },
}
