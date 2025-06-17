local M = {}

function M.setup()
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    sync_root_with_cwd = true,    -- เปลี่ยน root ของ NvimTree ตาม CWD (Current Working Directory)
    renderer = {
      group_empty = true,         -- จัดกลุ่มโฟลเดอร์ที่ว่างเปล่า
      full_name = true,           -- แสดงชื่อไฟล์แบบเต็ม (รวมถึงไอคอนและ Git status)
      icons = {
        webdev_colors = true,     -- ใช้สีของ icons จาก nvim-web-devicons
        git_placement = "before", -- วางสัญลักษณ์ Git ก่อนชื่อไฟล์/โฟลเดอร์
        padding = " ",            -- ระยะห่างระหว่าง icon และชื่อ
        symlink_arrow = " ➜ ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            arrow_open = "",
            arrow_closed = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "",
            staged = "✓",
            untracked = "",
            ignored = "",
            deleted = "",
          },
        },
      },
    },
    view = {
      width = 30, -- ความกว้างของหน้าต่าง NvimTree
      -- adaptive_size = true, -- ปรับขนาดอัตโนมัติ (optional)
      -- side = "left",        -- แสดง NvimTree ทางซ้าย
      -- hide_root_folder = false, -- ซ่อนโฟลเดอร์ root (optional)
      preserve_window_proportions = true, -- รักษาอัตราส่วนของหน้าต่าง
      number = false,                     -- ไม่แสดงเลขบรรทัด
      relativenumber = false,             -- ไม่แสดงเลขบรรทัดแบบสัมพัทธ์
      float = {
        enable = false,                   -- ไม่แสดงแบบ floating window
        open_fn = nil,                    -- ฟังก์ชันที่ใช้เปิด (ถ้า enable เป็น true)
        quit_on_focus_loss = false,
        -- win_panel_pos = "top",
      },
    },
    actions = {
      open_file = {
        quit_on_open = false, -- ไม่ปิด NvimTree เมื่อเปิดไฟล์
        resize_window = true, -- ปรับขนาดหน้าต่างเมื่อเปิดไฟล์
        window_picker = {
          enable = true,      -- เปิดใช้งาน window picker
          chars = "abcdefghijklmnopqrstuvwxyz",
          exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "nofile", "terminal", "prompt" },
          },
        },
      },
    },
    git = {
      enable = true,  -- เปิดใช้งานการแสดงผล Git status
      ignore = false, -- ไม่ต้อง ignore ไฟล์ที่ Git ignore
      timeout = 500,  -- Timeout สำหรับการตรวจสอบ Git status
    },
    -- diagnostics = {
    -- 	enable = true, -- แสดง LSP diagnostics ใน NvimTree
    -- 	show_on_dirs = true,
    -- 	colors = {
    -- 		hint = "#65B0FF",
    -- 		info = "#7AA2F7",
    -- 		warn = "#E0AF68",
    -- 		error = "#F7768E",
    -- 	},
    -- },
    -- ... (การตั้งค่าอื่นๆ ตามที่คุณต้องการ)
  })
end

return M
