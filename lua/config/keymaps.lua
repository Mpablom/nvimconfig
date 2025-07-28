-- ~/.config/nvim/lua/config/keymaps.lua
-- Keymaps are automatically loaded on the VeryLazy event

-- =============================================
-- Basic mappings
-- =============================================
vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode", noremap = true })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Salir del modo inserción" })

-- =============================================
-- Editing
-- =============================================
vim.keymap.set("n", "<leader>Dl", "yyp", { desc = "Duplicate Line" })

-- =============================================
-- Testing (Neotest)
-- =============================================
vim.keymap.set("n", "<leader>to", function()
  require("neotest").output_panel.toggle()
end, { desc = "Toggle Output Panel" })
vim.keymap.set("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "Toggle Summary" })
vim.keymap.set("n", "<leader>tn", function()
  require("neotest").run.run()
end, { desc = "Run Nearest Test" })
vim.keymap.set("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run Tests in File" })
vim.keymap.set("n", "<leader>tp", function()
  require("neotest").run.run(vim.loop.cwd())
end, { desc = "Run Tests in Project" })
vim.keymap.set("n", "<leader>tx", function()
  require("neotest").run.stop()
end, { desc = "Stop Running Test" })

-- =============================================
-- Debugging (DAP)
-- =============================================
vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Continue Debugging" })
vim.keymap.set("n", "<F9>", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Step Into" })
vim.keymap.set("n", "<F12>", function()
  require("dap").repl.open()
end, { desc = "Open REPL" })
vim.keymap.set("n", "<F6>", function()
  require("dap").close()
end, { desc = "Close Debugging Session" })
vim.keymap.set("n", "<leader>dr", function()
  require("dap").restart()
end, { desc = "Restart Debugging Session" })

-- =============================================
-- Debugging UI (DAP UI)
-- =============================================
vim.keymap.set("n", "<leader>de", function()
  require("dapui").eval()
end, { desc = "Evaluate Expression" })
vim.keymap.set("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle DAP UI" })

-- =============================================
-- Java (jdtls)
-- =============================================
vim.keymap.set("n", "<leader>tc", function()
  require("jdtls").test_class()
end, { desc = "Run All Tests in Class" })
vim.keymap.set("n", "<leader>tm", function()
  require("jdtls").test_nearest_method()
end, { desc = "Run Nearest Test Method" })

-- =============================================
-- Window Management
-- =============================================
vim.keymap.set("n", "<leader>vs", ":vsplit<CR>", { desc = "Open Split Vertical" })

-- =============================================
-- Build/Run Commands
-- =============================================
vim.keymap.set(
  "n",
  "<leader>m",
  ":w<CR>:botright 25split | terminal mvn spring-boot:run<CR>",
  { desc = "Ejecutar Maven Spring Boot" }
)
vim.keymap.set("n", "<leader>M", ":call system('killall mvn')<CR>", { desc = "Detener Maven Spring Boot" })
vim.keymap.set(
  "n",
  "<leader>G",
  ":w<CR>:botright 25split | terminal ./gradlew bootRun<CR>",
  { desc = "Ejecutar Gradle Spring Boot" }
)
vim.keymap.set("n", "<leader>Gs", ":call system('killall gradle')<CR>", { desc = "Detener Gradle Spring Boot" })
vim.keymap.set(
  "n",
  "<leader>an",
  ":w<CR>:botright 24split | terminal ng serve<CR>",
  { desc = "Ejecutar Angular ng serve" }
)
vim.keymap.set("n", "<leader>AN", ":call system('killall ng')<CR>", { desc = "Detener Angular ng serve" })
vim.keymap.set(
  "n",
  "<leader>r",
  ":w<CR>:botright 25split | terminal python3 %<CR>",
  { desc = "Ejecutar Python", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>ph",
  ":w<CR>:botright 25split | terminal php -S localhost:8000<CR>",
  { desc = "Ejecutar Php" }
)
vim.keymap.set("n", "<leader>Ph", ":call system('killall php')<CR>", { desc = "Detener Php" })

-- =============================================
-- Dvorak Movement Keys
-- =============================================
local dvorak_mappings = {
  { "t", "j", desc = "Move Down" },
  { "n", "k", desc = "Move Up" },
  { "s", "l", desc = "Move Right" },
}

for _, map in ipairs(dvorak_mappings) do
  vim.keymap.set({ "n", "v", "o" }, map[1], map[2], { desc = map.desc })
end

-- =============================================
-- Laravel
-- =============================================
vim.keymap.set("n", "<leader>la", "<cmd>Laravel artisan<cr>", { desc = "Laravel Artisan" })
vim.keymap.set("n", "<leader>lr", "<cmd>Laravel routes<cr>", { desc = "Laravel Routes" })
vim.keymap.set("n", "<leader>lm", "<cmd>Laravel related<cr>", { desc = "Laravel Related Files" })

-- =============================================
-- Go
-- =============================================
vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<CR>", { desc = "Go Test", noremap = true, silent = true })
vim.keymap.set("n", "<leader>gr", "<cmd>GoRun<CR>", { desc = "Go Run", noremap = true, silent = true })
vim.keymap.set("n", "<leader>gc", "<cmd>GoCoverage<CR>", { desc = "Go Coverage", noremap = true, silent = true })

-- =============================================
-- Save File Function and Mapping
-- =============================================
local function SaveFile()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.fn.expand("%:t")

  if vim.bo[bufnr].buftype ~= "" or vim.fn.expand("%") == "" then
    vim.notify("📭 No file to save", vim.log.levels.WARN)
    return
  end

  local write_cmd = "silent! write"
  if filename == "init.lua" then
    write_cmd = "silent! write | luafile %"
  end

  local success, err = pcall(vim.cmd, write_cmd)

  if success then
    vim.notify(("✅ %s saved successfully!"):format(filename), vim.log.levels.INFO)
  else
    local clean_err = err:gsub("\n", " "):gsub("^Vim%(write%)?:?", "")
    vim.notify(("❌ Failed to save %s: %s"):format(filename, clean_err), vim.log.levels.ERROR)
  end
end

vim.keymap.set("n", "<C-s>", SaveFile, { desc = "Save file" })

-- =============================================
-- Additional Configuration
-- =============================================
-- Deshabilitar teclas no deseadas
local disable_keys = {
  { "i", "<A-j>" },
  { "i", "<A-k>" },
  { "n", "<A-j>" },
  { "n", "<A-k>" },
  { "x", "<A-j>" },
  { "x", "<A-k>" },
  { "x", "J" },
  { "x", "K" },
}

for _, key in ipairs(disable_keys) do
  vim.api.nvim_set_keymap(key[1], key[2], "<Nop>", { noremap = true, silent = true })
end

-- Comandos Artisan
vim.keymap.set("n", "<leader>am", ":Artisan make:", { desc = "Artisan Make" })
vim.keymap.set("n", "<leader>ar", ":Artisan route:list<CR>", { desc = "List Routes" })
vim.keymap.set("n", "<leader>at", ":Artisan tinker<CR>", { desc = "Tinker" })

-- Navegación entre componentes
vim.keymap.set("n", "<leader>av", ":A view<CR>", { desc = "Go to View" })
vim.keymap.set("n", "<leader>ac", ":A controller<CR>", { desc = "Go to Controller" })
vim.keymap.set("n", "<leader>am", ":A model<CR>", { desc = "Go to Model" })
