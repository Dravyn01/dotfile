local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local status, err = pcall(vim.fn.system, {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  print(status)
end

vim.opt.rtp:prepend(lazypath)

-- plugins
require("plugins")

-- config
require("config.lualine")
require("config.lsp_servers")

require("keymaps")
require("options")

vim.cmd "colorscheme habamax"
