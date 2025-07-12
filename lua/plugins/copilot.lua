return {
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""

      vim.keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', {
        silent = true,
        expr = true,
        script = true,
        replace_keycodes = false,
      })
      vim.keymap.set("i", "<C-N>", "<Plug>(copilot-next)")
      vim.keymap.set("i", "<C-T>", "<Plug>(copilot-previous)")
      vim.keymap.set("i", "<C-E>", "<Plug>(copilot-dismiss)")
      vim.keymap.set("i", "<C-Space>", "<Plug>(copilot-suggest)")
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
