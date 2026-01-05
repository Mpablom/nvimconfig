return {
  "jameswolensky/marker-groups.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim", -- Optional: Telescope picker
  },
  config = function()
    require("marker-groups").setup({
      picker = "telescope",
    })
  end,
}
