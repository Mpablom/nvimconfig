return {
  "mistweaverco/kulala.nvim",
  -- Cargar antes de guardar/restaurar sesiones
  event = { "SessionLoadPost", "VimLeavePre" },
  keys = {
    { "<leader>Rs", desc = "Send request" },
    { "<leader>Ra", desc = "Send all requests" },
    { "<leader>Rb", desc = "Open scratchpad" },
  },
  ft = { "http", "rest", "javascript", "lua" },
  opts = {
    kulala_core = {
      path = nil, -- Auto-descarga del backend
      timeout = 60000, -- Timeout de 1 minuto
      data_dir = nil, -- Directorio por defecto
    },

    default_env = "default",
    environment_scope = "b", -- Por buffer

    response_format = {
      indent = 2,
      expand_tabs = true,
      sort_keys = false,
    },

    ui = {
      display_mode = "split", -- o "float"
      split_direction = "right",
      winbar = true,
      default_view = "body",
      show_icons = "on_request",
      icons = {
        inlay = {
          loading = "⏳",
          done = "✔",
          error = "✘",
        },
      },
      show_request_summary = true,
      max_response_size = 32768,

      scratchpad_default_contents = {
        "@MY_TOKEN_NAME=my_token_value",
        "",
        "# @name scratchpad",
        "POST https://echo.kulala.app/post HTTP/1.1",
        "accept: application/json",
        "content-type: application/json",
        "",
        "{",
        '  "foo": "bar"',
        "}",
      },
    },

    lsp = {
      enable = true,
      filetypes = { "http", "rest", "javascript", "typescript", "lua" },
      enforce_external_script_naming_convention = true,
      keymaps = false, -- Desactivado por defecto
    },

    debug = 3,
    global_keymaps = false, -- Cambia a true si quieres keymaps globales
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps = true,
    kulala_keymaps_prefix = "",
  },
}
