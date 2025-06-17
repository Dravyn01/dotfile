-- General options
vim.opt.nu = true             -- แสดงเลขบรรทัด
vim.opt.relativenumber = true -- แสดงเลขบรรทัดแบบสัมพัทธ์
vim.opt.mouse = "a"           -- เปิดใช้งานเมาส์ในทุกโหมด
vim.opt.expandtab = true      -- ใช้ space แทน tab
vim.opt.tabstop = 2           -- กำหนดขนาด tab เป็น 2 space
vim.opt.shiftwidth = 2        -- จำนวน space ที่ใช้ในการเยื้อง
vim.opt.smartindent = true    -- เยื้องอัตโนมัติอย่างชาญฉลาด
vim.opt.autoindent = true     -- เปิดใช้งานการเยื้องอัตโนมัติ
-- vim.g.indent = 4            -- ลบออก: การตั้งค่านี้มักจะถูกจัดการด้วย tabstop/shiftwidth

-- UI/Appearance
vim.opt.termguicolors = true -- เปิดใช้งาน true color ใน terminal
vim.opt.showmode = false     -- ไม่แสดงโหมดปัจจุบันใน statusline (จัดการโดย lualine/statusline plugin แทน)
vim.opt.cmdheight = 1        -- ความสูงของบรรทัดคำสั่ง
vim.opt.updatetime = 300     -- เวลาที่ Neovim รอการเปลี่ยนแปลงไฟล์ (สำหรับ LSP)
vim.opt.signcolumn = "yes"   -- แสดงคอลัมน์สำหรับ signs (เช่น warnings/errors) เสมอ
vim.opt.scrolloff = 8        -- จำนวนบรรทัดที่ Neovim จะรักษาระหว่างเคอร์เซอร์กับขอบจอ
vim.o.wrap = false           -- ปิดการตัดข้อความขึ้นบรรทัดใหม่ (wrap text)

-- Search options
vim.opt.incsearch = true -- แสดงผลการค้นหาขณะพิมพ์
vim.opt.hlsearch = true  -- ไฮไลท์ผลการค้นหา

-- ปิดการใช้งาน Swapfile (ถ้าคุณไม่ชอบ)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

-- ประสิทธิภาพ
-- vim.opt.syntax = "on"        -- ลบออก: มักจะจัดการโดย nvim-treesitter อยู่แล้ว
vim.opt.hidden = true        -- อนุญาตให้บัฟเฟอร์ซ่อนอยู่เมื่อเปลี่ยนไปบัฟเฟอร์อื่น
vim.opt.inccommand = "split" -- แสดงผลคำสั่ง :s/search/replace/g แบบเรียลไทม์ใน
