local M = {}

function M.setup()
  -- ลดเวลาหน่วงก่อนที่ WhichKey จะแสดงเมนู (milliseconds)
  vim.o.timeoutlen = 300

  require("which-key").setup({
    -- ตั้งค่าเริ่มต้นของ WhichKey (สามารถปรับแต่งเพิ่มเติมได้)
    -- plugins = {
    --   marks = true, -- shows a list of your marks on '
    --   registers = true, -- shows your registers on "
    --   spelling = {
    --     enabled = true, -- shows spelling suggestions on z=
    --     suggestions = 20, -- how many suggestions should be shown in the list
    --   },
    --   presets = {
    --     operators = false, -- adds help for operators like d, y, ...
    --     motions = false, -- adds help for motions like w, e, h, l, ...
    --     text_objects = false, -- adds help for text objects like iw, aw, as, ...
    --     windows = true, -- default bindings for window movement.
    --     nav = true, -- default bindings for navigating through buffers, quickfix and location list
    --     z = true, -- default bindings for folds, spelling and others prefixed with z
    --     g = true, -- default bindings for prefixed with g
    --   },
    -- },
    -- your existing mappings will be shown with a `-` indicating they are not loaded by which-key
    -- show_help = false,
    -- key_labels = {
    --   ["<leader>"] = "Leader",
    -- },
  })

  -- คุณสามารถเพิ่มเมนูย่อยของ WhichKey ได้ที่นี่
  -- ตัวอย่าง:
  -- local wk = require("which-key")
  -- wk.register({
  --   f = {
  --     name = "File",
  --     w = { ":w<CR>", "Save" },
  --     q = { ":q<CR>", "Quit" },
  --   },
  --   l = {
  --     name = "LSP",
  --     d = { vim.lsp.buf.definition, "Definition" },
  --     r = { vim.lsp.buf.references, "References" },
  --   },
  -- }, { prefix = "<leader>" })
end

return M
