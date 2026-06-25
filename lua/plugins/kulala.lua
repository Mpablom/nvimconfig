return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  keys = {
    {
      "<leader>Rs",
      function()
        require("kulala").run()
      end,
      desc = "Send request",
    },
    {
      "<leader>Ra",
      function()
        require("kulala").run_all()
      end,
      desc = "Send all requests",
    },
    {
      "<leader>Rb",
      function()
        require("kulala").scratchpad()
      end,
      desc = "Open scratchpad",
    },
    {
      "<leader>Rp",
      function()
        require("kulala").toggle_view()
      end,
      desc = "Toggle response view",
    },
  },
  opts = {
    default_env = "default",
    environment_scope = "b",

    ui = {
      display_mode = "split",
      split_direction = "right",
      winbar = true,
      default_view = "body",
    },
  },
}
