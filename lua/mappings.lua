require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- duplicate line
map("n", "<leader>dl", "yyp", { desc = "Duplicate Line" })

-- Neotest
map("n", "<leader>to", function() require('neotest').output_panel.toggle() end, { desc = "Toggle Output Panel" })
map("n", "<leader>ts", function() require('neotest').summary.toggle() end, { desc = "Toggle Summary" })
map("n", "<leader>tn", function() require('neotest').run.run() end, { desc = "Run Nearest Test" })
map("n", "<leader>tf", function() require('neotest').run.run(vim.fn.expand('%')) end, { desc = "Run Tests in File" })
map("n", "<leader>tp", function() require('neotest').run.run(vim.loop.cwd()) end, { desc = "Run Tests in Project" })
map("n", "<leader>tx", function() require('neotest').run.stop() end, { desc = "Stop Running Test" })

-- nvim-dap mappings
map("n", "<F5>", function() require('dap').continue() end, { desc = "Continue Debugging" })
map("n", "<F9>", function() require('dap').toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map("n", "<F10>", function() require('dap').step_over() end, { desc = "Step Over" })
map("n", "<F11>", function() require('dap').step_into() end, { desc = "Step Into" })
map("n", "<F12>", function() require('dap').repl.open() end, { desc = "Open REPL" })
map("n", "<F6>", function() require('dap').close() end, { desc = "Close Debugging Session" })
map("n", "<leader>dr", function() require('dap').restart() end, { desc = "Restart Debugging Session" })

-- nvim-dap UI mappings
map("n", "<leader>de", function() require('dapui').eval() end, { desc = "Evaluate Expression" })
map("n", "<leader>du", function() require('dapui').toggle() end, { desc = "Toggle DAP UI" })

map("n", "<leader>tc", function() require'jdtls'.test_class() end, { desc = "Run All Tests in Class" })
map("n", "<leader>tm", function() require'jdtls'.test_nearest_method() end, { desc = "Run Nearest Test Method" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Open buffer in split vertical
map("n", "<leader>vs", ":vsplit<CR>", { desc = "Open Split Vertical" })

-- Run Maven Spring Boot
map("n", "<leader>m", ":w<CR>:botright 25split | terminal mvn spring-boot:run<CR>", { desc = "Ejecutar Maven Spring Boot" })
map("n", "<leader>M", ":call system('killall mvn')<CR>", { desc = "Detener Maven Spring Boot" })
-- Run Gradle Spring Boot
map("n", "<leader>g", ":w<CR>:botright 25split | terminal ./gradlew bootRun<CR>", { desc = "Ejecutar Gradle Spring Boot" })
map("n", "<leader>G", ":call system('killall gradle')<CR>", { desc = "Detener Gradle Spring Boot" })
-- Run Angular ng serve
map("n", "<leader>a", ":w<CR>:botright 25split | terminal ng serve<CR>", { desc = "Ejecutar Angular ng serve" })
map("n", "<leader>A", ":call system('killall ng')<CR>", { desc = "Detener Angular ng serve" })
-- Run Python
map("n", "<leader>r", ":w<CR>:botright 25split | terminal python3 %<CR>", { noremap = true, silent = true, desc = "Ejecutar Python" })
-- Run Php local
map("n", "<leader>ph", ":w<CR>:botright 25split | terminal php -S localhost:8000<CR>", { desc = "Ejecutar Php" })
map("n", "<leader>Ph", ":call system('killall php')<CR>", { desc = "Detener Php" })

-- Dvorak movement keys
map("n", "h", "h", { desc = "Move Left" })
map("n", "t", "j", { desc = "Move Down" })
map("n", "n", "k", { desc = "Move Up" })
map("n", "s", "l", { desc = "Move Right" })

map("v", "h", "h", { desc = "Move Left" })
map("v", "t", "j", { desc = "Move Down" })
map("v", "n", "k", { desc = "Move Up" })
map("v", "s", "l", { desc = "Move Right" })

map("o", "h", "h", { desc = "Move Left" })
map("o", "t", "j", { desc = "Move Down" })
map("o", "n", "k", { desc = "Move Up" })
map("o", "s", "l", { desc = "Move Right" })

vim.wo.relativenumber = true
vim. o.number = true

-- Laravel
local map = vim.keymap.set
map("n", "<leader>la", "<cmd>Laravel artisan<cr>", { desc = "Laravel Artisan" })
map("n", "<leader>lr", "<cmd>Laravel routes<cr>", { desc = "Laravel Routes" })
map("n", "<leader>lm", "<cmd>Laravel related<cr>", { desc = "Laravel Related Files" })

-- Debugging
map("n", "<F5>", function() require("dap").continue() end, { desc = "Debug: Start/Continue" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: Step Over" })
