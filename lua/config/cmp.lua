local M = {}

function M.setup()
  local cmp = require("cmp")

  local luasnip = require("luasnip")

  local kind_icons = {
    Array = "  ",
    Boolean = "  ",
    Class = "  ",
    Color = "  ",
    Constant = "  ",
    Constructor = "  ",
    Enum = "  ",
    EnumMember = "  ",
    Event = "  ",
    Field = "  ",
    File = "  ",
    Folder = " 󰉋 ",
    Function = "  ",
    Interface = "  ",
    Key = "  ",
    Keyword = "  ",
    Method = "  ",
    Module = "  ",
    Namespace = "  ",
    Null = " 󰟢 ",
    Number = "  ",
    Object = "  ",
    Operator = "  ",
    Package = "  ",
    Property = "  ",
    Reference = "  ",
    Snippet = "  ",
    String = "  ",
    Struct = "  ",
    Text = "  ",
    TypeParameter = "  ",
    Unit = "  ",
    Value = "  ",
    Variable = "  ",
  }

  cmp.setup({
    -- setup Snippet engine
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- use luasnip for snippet
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },

    -- Keymap for nvim-cmp
    mapping = cmp.mapping.preset.insert({
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<Enter>"] = cmp.mapping.confirm({ select = true }),

      ["<Up>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's', 'n' }),

      ["<Down>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()   -- เลื่อนเลือกรายการถัดไปในเมนู completion
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump() -- ถ้ามี snippet ให้ขยายหรือกระโดดไปส่วนถัดไป
        else
          fallback()               -- ทำงานตามค่าเริ่มต้น
        end
      end, { 'i', 's' }),          -- ใช้ได้ในโหมด Insert และ Select (ของ snippet)
    }),

    -- แหล่งข้อมูลสำหรับการเติมข้อความอัตโนมัติ (เรียงตามลำดับความสำคัญ)
    sources = cmp.config.sources({
      { name = "nvim_lsp" }, -- ดึงข้อมูลจาก LSP servers
      { name = "luasnip" },  -- ดึงข้อมูลจาก snippets ของ LuaSnip
      { name = "buffer" },   -- ดึงคำจากบัฟเฟอร์ปัจจุบัน
      { name = "path" },     -- ดึงชื่อไฟล์และเส้นทาง
    }),

    -- การแสดงผลของเมนู completion
    --window = {
    -- completion = cmp.config.window.bordered(),    -- เพิ่มขอบเมนู completion
    -- documentation = cmp.config.window.bordered(), -- มีขอบรอบหน้าต่าง documentation
    --},

    formatting = {
      format = function(entry, vim_item)
        -- เพิ่ม Icon ตามชนิดของ LSP kind
        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
        vim_item.menu = ({
          buffer = "[B]",
          nvim_lsp = "[L]",
          luasnip = "[S]",
          path = "[P]",
        })[entry.source.name]
        return vim_item
      end,
    },
  })
end

return M
