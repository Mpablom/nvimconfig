return {
  "nomnivore/ollama.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

  -- Los comandos que agrega el plugin para interactuar con Ollama
  cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

  -- Mapeos de teclas para invocar los prompts
  keys = {
    {
      "<leader>oo",
      ":<c-u>lua require('ollama').prompt()<cr>",
      desc = "Ollama: Prompt",
      mode = { "n", "v" },
    },
    {
      "<leader>oG",
      ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
      desc = "Ollama: Generar Código",
      mode = { "n", "v" },
    },
    {
      "<leader>oA",
      ":<c-u>lua require('ollama').prompt('Analizar_Codigo')<cr>",
      desc = "Ollama: Analizar Código",
      mode = { "n", "v" },
    },
    {
      "<leader>oD",
      ":<c-u>lua require('ollama').prompt('Documentar_Codigo')<cr>",
      desc = "Ollama: Documentar Código",
      mode = { "n", "v" },
    },
  },

  ---@type Ollama.Config
  opts = {
    model = "deepseek-r1:14B",         -- Modelo por defecto para completions
    url = "https://many-webs-carry.loca.lt/", -- URL de tu servidor Ollama
    serve = {
      on_start = false,        -- No se inicia automáticamente
      command = "ollama",      -- Comando para arrancar el servidor
      args = { "serve" },
      stop_command = "pkill",  -- Comando para detener el servidor
      stop_args = { "-SIGTERM", "ollama" },
    },
    -- Configura tus prompts personalizados
    prompts = {
      -- Prompt general en español
      Prompt_Espanol = {
        prompt = "Responde siempre en español de manera clara y concisa: $input",
        input_label = "> ",
        model = "deepseek-r1:14B",
        action = "display",   -- Opciones: display, replace, insert, etc.
      },
      -- Prompt para generar código
      Generar_Codigo = {
        prompt = "Genera código en español. Asegúrate de que el código sea funcional y esté bien documentado: $input",
        input_label = "> ",
        model = "deepseek-r1:14B",
        action = "replace",  -- Reemplaza el texto seleccionado con la respuesta
      },
      -- Prompt para analizar código
      Analizar_Codigo = {
        prompt = "Analiza el siguiente código y proporciona feedback en español. Explica qué hace el código, su complejidad y sugiere mejoras si es necesario:\n\n$sel",
        input_label = "> ",
        model = "deepseek-r1:14B",
        action = "display",
      },
      -- Prompt para documentar código
      Documentar_Codigo = {
        prompt = "Documenta el siguiente código en español. Explica su propósito, los parámetros que recibe, lo que devuelve y cualquier detalle relevante:\n\n$sel",
        input_label = "> ",
        model = "deepseek-r1:14B",
        action = "display",
      },
      -- Prompt para refactorizar código
      Refactorizar_Codigo = {
        prompt = "Refactoriza el siguiente código para mejorar su legibilidad, eficiencia o estructura. Explica los cambios en español:\n\n$sel",
        input_label = "> ",
        model = "deepseek-r1:14B",
        action = "replace",
      },
    },
  },
}
