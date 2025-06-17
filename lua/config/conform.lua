local M = {}

function M.setup()
  require("conform").setup({
    -- กำหนด formatter สำหรับแต่ละประเภทไฟล์ (filetype)
    formatters_by_ft = {
      lua = { "stylua" }, -- ใช้ stylua สำหรับไฟล์ .lua
      -- คุณสามารถเพิ่มภาษาอื่น ๆ และ formatter ที่เกี่ยวข้องได้ที่นี่
      javascript = { "prettier" },
      typescript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
    },
    -- ตั้งค่าให้ format เมื่อบันทึกไฟล์ (optional แต่แนะนำอย่างยิ่ง)
    format_on_save = {
      timeout_ms = 500,                                               -- กำหนด timeout สำหรับการจัดรูปแบบ
      lsp_format = "fallback",                                        -- หากไม่มี formatter ของ conform จะใช้ LSP formatter แทน
      filter = function(client) return client.name ~= "tsserver" end, -- กรอง client ที่ไม่ต้องการให้ format
    },
    -- ตัวเลือกอื่นๆ (optional)
    notify_on_error = true,           -- แสดงการแจ้งเตือนเมื่อเกิดข้อผิดพลาดในการ format
    log_level = vim.log.levels.DEBUG, -- ตั้งค่า log level สำหรับ debugging
  })

  -- กำหนด Keymap สำหรับการจัดรูปแบบด้วยตนเอง (หากไม่ได้ตั้งค่า format_on_save)
  -- <leader>fm จะเรียก conform.format()
  vim.keymap.set({ "n", "v" }, "<leader>fm", function()
    require("conform").format({
      lsp_format = "fallback",
      async = false, -- ทำให้การจัดรูปแบบเป็น synchronous เพื่อให้แน่ใจว่าเสร็จก่อน
      -- คุณสามารถเพิ่ม opts ที่นี่ได้ถ้าต้องการ
    })
  end, { desc = "Format file/selection (conform)" })
end

return M
