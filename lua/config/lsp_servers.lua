local M = {}

-- ฟังก์ชันหลักที่จะเรียกตั้งค่า LSP servers ทั้งหมด
function M.setup_all_ls()
  local lspconfig = require("lspconfig")
  local on_attach = require("config.lsp").on_attach -- ดึงฟังก์ชัน on_attach มาจาก config.lsp

  -- 1. ตั้งค่า Lua Language Server (lua_ls)
  lspconfig.lua_ls.setup({
    on_attach = on_attach, -- ใช้ on_attach ที่เราดึงมา
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

  -- 3. ตั้งค่า HTML Language Server (html)
  lspconfig.html.setup({
    on_attach = on_attach,
  })

  -- 4. ตั้งค่า CSS Language Server (cssls)
  lspconfig.cssls.setup({
    on_attach = on_attach,
  })

  -- 5. ตั้งค่า JSON Language Server (jsonls)
  lspconfig.jsonls.setup({
    on_attach = on_attach,
  })

  -- 6. ตั้งค่า ESLint Language Server (eslint)
  -- ต้องมั่นใจว่าคุณได้ติดตั้ง ESLint ในโปรเจกต์ของคุณด้วย
  lspconfig.eslint.setup({
    on_attach = on_attach,
    -- settings: เช่นการเปิดใช้งานสำหรับบาง filetypes
    settings = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine",
        },
        showSources = "off",
      },
      format = true,
    },
  })

  -- คุณสามารถเพิ่ม LSP servers อื่นๆ ที่นี่ได้ตามความต้องการ เช่น:
  -- lspconfig.emmet_ls.setup({ on_attach = on_attach }) -- สำหรับ Emmet ใน HTML/CSS
  -- lspconfig.deno.setup({ on_attach = on_attach }) -- ถ้าใช้ Deno
  lspconfig.yamlls.setup({ on_attach = on_attach })        -- สำหรับ YAML
  lspconfig.rust_analyzer.setup({ on_attach = on_attach }) -- สำหรับ Rust
  lspconfig.emmet_ls.setup({
    on_attach = on_attach,
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

return M
