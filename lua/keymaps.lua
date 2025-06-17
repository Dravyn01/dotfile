-- กำหนดฟังก์ชัน map เพื่อให้การสร้างปุ่มลัดสั้นลงและอ่านง่ายขึ้น
local map = vim.keymap.set
vim.g.mapleader = " "

-- ==============================
-- 1. ปุ่มลัดทั่วไป (General Keymaps)
-- ==============================

-- Clear search highlight with <leader>nh (leader + n + h)
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlight" })

-- Quit Neovim with <leader>qq (leader + q + q)
map("n", "<leader>qq", ":qa<CR>", { desc = "Quit all windows" })

-- Save file with <leader>w (leader + w)
map("n", "<leader>w", ":w<CR>", { desc = "Save current file" })

map("n", ";", ":")

-- ==============================
-- 2. ปุ่มลัดสำหรับการจัดการหน้าต่าง/บัฟเฟอร์ (Window/Buffer Management)
-- ==============================

-- Navigate between windows (like tmux)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- open folder
map("n", "<leader>o", ":NvimTreeToggle<CR>")

-- ==============================
-- 3. ปุ่มลัดสำหรับ LSP และ Formatting
-- ==============================

-- จัดรูปแบบโค้ดด้วย <leader>fm (leader + f + m)
-- (คำสั่งนี้ถูกตั้งค่าโดย conform.nvim อยู่แล้ว แต่เราก็ยังสามารถ map ได้ที่นี่)
-- map({"n", "v"}, "<leader>fm", function()
--   require("conform").format({
--     lsp_format = "fallback",
--     async = false, -- ทำให้การจัดรูปแบบเป็น synchronous เพื่อให้แน่ใจว่าเสร็จก่อน
--   })
-- end, { desc = "Format file/selection (conform)" })

-- Go to definition (gd)
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
-- Go to type definition (gD)
map("n", "gD", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
-- Go to references (gr)
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
-- Rename (grn)
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
-- Code Action (gca)
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- แสดง Diagnostics (ข้อผิดพลาด/คำเตือน)
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- typescript tools
map("n", "<leader>oi", "<cmd>TSToolsOrganizeImports<CR>", { desc = "Organize Imports" })
map("n", "<leader>rf", "<cmd>TSToolsRenameFile<CR>", { desc = "" })
map("n", "<leader>rf", "<cmd>TSToolsFixAll<CR>", { desc = "fix all" })
map("n", "<leader>ia", "<cmd>TSToolsAddMissingImports<CR>", { desc = "add missing imports" })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "find files" })
map("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "find files" })
