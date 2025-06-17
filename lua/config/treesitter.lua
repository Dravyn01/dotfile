local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    highlight = {
      enable = true, -- เปิดใช้งาน syntax highlighting
      -- คุณสามารถกำหนดภาษาที่จะไม่ไฮไลท์ได้ที่นี่ เช่น `disable = { "python" }`
    },
    indent = {
      enable = true, -- เปิดใช้งานการเยื้องอัตโนมัติ
    },
    -- กำหนด parsers ที่จะติดตั้งโดยอัตโนมัติ (เมื่อรัน :TSUpdate)
    ensure_installed = {
      "lua", -- สำหรับภาษา Lua
      "vim", -- สำหรับไฟล์ config ของ Neovim (vimscript)
      "javascript", 
      "typescript",
      "html",
      "css",
    },
    -- ตัวเลือกอื่นๆ (optional)
    -- auto_install = true, -- ติดตั้ง parsers โดยอัตโนมัติหากไม่มี (ควรเป็น false ใน Production เพื่อควบคุม)
    -- ignore_install = { "php" }, -- ไม่ต้องติดตั้ง parser สำหรับ PHP
  })
end

return M

