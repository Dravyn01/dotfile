local M = {}
local conf = require("lspconfig")

M.on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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
    source = true,
    header = "",
    prefix = "",
  },
})

function M.setup_lua_ls()
  conf.lua_ls.setup({
    on_attach = M.on_attach,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT", -- หรือ "5.1", "5.2", "5.3", "5.4" ตามเวอร์ชัน Lua ที่คุณใช้
          path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim/lua/lazy/**/*.lua',
          pathStrict = false,
        },
        diagnostics = {
          globals = { 'vim' }, -- lua vim globals
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
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

function M.setup_html()
  conf.html.setup({
    on_attach = M.on_attach,
  })
end

function M.setup_cssls()
  conf.cssls.setup({
    on_attach = M.on_attach,
  })
end

function M.setup_jsonls()
  conf.jsonls.setup({
    on_attach = M.on_attach,
  })
end

function M.setup_typescript()
  conf.ts_ls.setup({
    on_attach = M.on_attach,
  })
end

function M.setup_emmet_ls()
  conf.emmet_ls.setup({
    on_attach = M.on_attach,
    filetypes = {
      "html",
      "css",
      "tailwind",
      "javascriptreact",
      "typescriptreact",
      "vue"
    },
  })
end

function M.setup_java()
  conf.jdtls.setup({
    on_attach = M.on_attach,
    settings = {
      java = {
        configuration = {
          runtimes = {
            {
              name = "JavaSE-17",
              path = "C:/Program Files/Java/jdk-17",
              default = true,
            }
          }
        }
      }
    }
  })
end

function M.setup_rust()
  conf.rust_analyzer.setup({
    on_attach = M.on_attach,
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = {
          command = "clippy"
        },
        inlayHints = {
          enable = true, -- แสดง hint ในตัวแปร เช่น type ของค่า
        },
        diagnostics = {
          enable = true,
        }
      }
    }
  })
end

return M
