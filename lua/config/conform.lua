local M = {}

function M.setup()
  require("conform").setup({
    formatters_by_ft = {
      -- formatting
      lua = { "stylua" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
    },
    -- format when save ffile
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
      filter = function(client) return client.name ~= "tsserver" end,
    },
    notify_on_error = true, -- alert when fail to format
    log_level = vim.log.levels.DEBUG,
  })

  -- vim.keymap.set({ "n", "v" }, "<leader>fm", function()
  --   require("conform").format({
  --     lsp_format = "fallback",
  --     async = false, -- ทำให้การจัดรูปแบบเป็น synchronous เพื่อให้แน่ใจว่าเสร็จก่อน
  --     -- คุณสามารถเพิ่ม opts ที่นี่ได้ถ้าต้องการ
  --   })
  -- end, { desc = "Format file/selection (conform)" })
end

return M
