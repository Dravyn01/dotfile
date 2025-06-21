-- กำหนดฟังก์ชัน map เพื่อให้การสร้างปุ่มลัดสั้นลงและอ่านง่ายขึ้น
local map = vim.keymap.set
vim.g.mapleader = " "

-- General Keymaps

-- save file
map("n", "<leader>w", ":w<CR>", { desc = "Save current file" })

-- shot cut
map("n", ";", ":")

-- Navigate between windows (like tmux)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- open folder
map("n", "<leader>o", ":NvimTreeToggle<CR>")

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
