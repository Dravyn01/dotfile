local M = {}

function M.setup()
  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "gruvbox",
      component_separators = { "", "" },
      section_separators = { "", "" },
      disabled_filetypes = {
        "NvimTree",
        "alpha",
      },
      always_last_line = false,
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        {
          function()
            local file = vim.api.nvim_buf_get_name(0)
            if file == "" then return "" end

            local icon = require("nvim-web-devicons").get_icon(file, nil, { default = true })
            local folder = vim.fn.fnamemodify(file, ":p:h:t")
            return icon .. " " .. folder
          end,
          icon_enabled = true,
          color = { gui = "bold" },
        },
        {
          "filename",
          path = 1,
          symbols = {
            modified = " ●",
            readonly = " ",
            unnamed = "[No Name]",
          },
        },
      },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          function()
            local file = vim.api.nvim_buf_get_name(0)
            if file == "" then return "" end
            local icon = require("nvim-web-devicons").get_icon(file, nil, { default = true })
            local folder = vim.fn.fnamemodify(file, ":p:h:t")
            return icon .. " " .. folder
          end,
        },
        {
          "filename",
          path = 1,
          symbols = {
            modified = " ●",
            readonly = " ",
            unnamed = "[No Name]",
          },
        },
      },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  })
end

return M
