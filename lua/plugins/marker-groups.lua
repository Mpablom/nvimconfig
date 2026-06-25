return {
  "jameswolensky/marker-groups.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("marker-groups").setup({
      pickers = {
        backend = "telescope", -- Forzar telescope, evitar detección de mini.pick
      },
    })
  end,
}
