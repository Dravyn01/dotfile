local M = {}

-- ฟังก์ชัน on_attach: จะถูกเรียกเมื่อ Language Server เชื่อมต่อกับ buffer
-- ใช้สำหรับตั้งค่า Keymaps และ Autocmds เฉพาะสำหรับ buffer นั้นๆ
M.on_attach = function(client, bufnr)
  -- Helper functions เพื่อให้โค้ดกระชับขึ้น
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- เปิดใช้งาน auto-completion ที่เรียกใช้โดย <c-x><c-o> (ถ้าต้องการ)
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- กำหนดปุ่มลัด (Keymaps) ที่เกี่ยวข้องกับ LSP สำหรับ buffer ปัจจุบัน
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>',
    { noremap = true, silent = true, desc = "Go to Declaration" })
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {
    noremap = true,
    silent = true,
    desc =
    "Go to Definition"
  })
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {
    noremap = true,
    silent = true,
    desc =
    "Hover Documentation"
  })
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>',
    { noremap = true, silent = true, desc = "Go to Implementation" })
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {
    noremap = true,
    silent = true,
    desc =
    "Go to References"
  })
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>',
    { noremap = true, silent = true, desc = "Rename Symbol" })
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
    { noremap = true, silent = true, desc = "Code Action" })
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
    { noremap = true, silent = true, desc = "Add Workspace Folder" })
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
    { noremap = true, silent = true, desc = "Remove Workspace Folder" })
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    { noremap = true, silent = true, desc = "List Workspace Folders" })
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>',
    { noremap = true, silent = true, desc = "Type Definition" })
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>',
    { noremap = true, silent = true, desc = "Format Code" })

  -- ถ้า server รองรับ, ตั้งค่า autocommand เพื่อไฮไลท์เมื่อ cursor อยู่นิ่ง (document highlight)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

vim.diagnostic.config({
  virtual_text = true,      -- แสดงข้อความผิดพลาดถัดจากบรรทัดโค้ด
  signs = true,             -- แสดงสัญลักษณ์ที่ gutter (แถบด้านซ้าย)
  underline = true,         -- ขีดเส้นใต้โค้ดที่มีปัญหา
  update_in_insert = false, -- ไม่อัปเดต diagnostics ใน Insert Mode
  float = {                 -- การตั้งค่าสำหรับหน้าต่าง pop-up (float window)
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- ฟังก์ชันสำหรับตั้งค่า Lua Language Server (lua_ls) โดยเฉพาะ
-- ฟังก์ชันนี้จะถูกเรียกโดย mason-lspconfig handler ใน plugins.lua
function M.setup_lua_ls()
  local lspconfig = require("lspconfig")
  lspconfig.lua_ls.setup({
    on_attach = M.on_attach, -- ใช้ on_attach ที่เราสร้างไว้ข้างบน
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT", -- หรือ "5.1", "5.2", "5.3", "5.4" ตามเวอร์ชัน Lua ที่คุณใช้
          -- ระบุ paths เพิ่มเติมหากต้องการให้ Lua LS รู้จัก global variables/modules ของคุณ
          path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim/lua/lazy/**/*.lua',
          pathStrict = false,
        },
        diagnostics = {
          globals = { 'vim' }, -- บอก Lua LS ให้รู้จัก 'vim' เป็น global
        },
        workspace = {
          -- กำหนด folder ที่จะให้ Lua LS ตรวจสอบและให้การ completion
          -- นี่เป็นสิ่งสำคัญสำหรับการ auto-completion ของ Neovim APIs
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            -- สามารถเพิ่ม path ไปยัง plugins ของคุณเพื่อให้ lua_ls รู้จัก
            -- [vim.fn.stdpath('config') .. '/lua'] = true,
          },
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })
end

-- คุณสามารถเพิ่มฟังก์ชัน setup_XYZ_ls() สำหรับ Language Server อื่นๆ ที่นี่ได้
-- ตัวอย่าง:
function M.setup_ts_ls()
  local tsConfig = require("lspconfig")
  tsConfig.ts_ls.setup({
    on_attach = M.on_attach,
  })
end

function M.setup_html()
  local htmlConfig = require("lspconfig")
  htmlConfig.html.setup({
    on_attach = M.on_attach,
  })
end

function M.setup_cssls()
  local cssConfig = require("lspconfig")
  cssConfig.cssls.setup({
    on_attach = M.on_attach,
  })
end

function M.setup_jsonls()
  local jsonConfig = require("lspconfig")
  jsonConfig.jsonls.setup({
    on_attach = M.on_attach,
  })
end

function M.setup_emmet_ls()
  local emmetConfig = require("lspconfig")
  emmetConfig.emmet_ls.setup({
    on_attach = M.on_attach,
  })
end

function M.setup_rust()
  local rustConfig = require("lspconfig")
  rustConfig.rust_analyzer.setup({
    on_attach = M.on_attach,
  })
end

return M -- <--- สำคัญมาก! ต้อง return ตาราง M ออกไป
