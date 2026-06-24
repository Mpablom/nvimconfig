return {
  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      keymaps = {
        accept_suggestion = nil, -- Lo maneja blink.cmp
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = { "bigfile", "snacks_input" },
      color = {
        suggestion_color = "#6CC644",
        cterm = 244,
      },
      log_level = "info",
      disable_inline_completion = false,
      disable_keymaps = false,
    },
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
    end,
  },
  -- Integración con blink.cmp (necesario porque Supermaven usa la API antigua de nvim-cmp)
  {
    "saghen/blink.compat",
    dependencies = { "supermaven-inc/supermaven-nvim" },
    opts = {
      sources = { "supermaven" },
    },
  },
}
