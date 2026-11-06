-- If LazyVim can't run on this host (nvim too old, no git, no network on first
-- start), fall back to the plain ~/.vimrc settings so nvim stays usable.
local function fallback(reason)
  local vimrc = vim.fn.expand("~/.vimrc")
  if vim.fn.filereadable(vimrc) == 1 then
    vim.cmd("silent! source " .. vim.fn.fnameescape(vimrc))
  end
  -- ~/.vimrc points undodir at vim's dir; nvim's undo format is incompatible
  vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
  vim.schedule(function()
    vim.notify("LazyVim disabled (" .. reason .. "), using ~/.vimrc settings", vim.log.levels.WARN)
  end)
end

if vim.fn.has("nvim-0.11") == 0 then
  local v = vim.version()
  return fallback(string.format("needs nvim >= 0.11, have %d.%d.%d", v.major, v.minor, v.patch))
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  if vim.fn.executable("git") == 0 then
    return fallback("git not found")
  end
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.fn.delete(lazypath, "rf")
    return fallback("could not clone lazy.nvim")
  end
end
vim.opt.rtp:prepend(lazypath)

local ok, err = pcall(require("lazy").setup, {
  spec = {
    -- LazyVim core; language/editor extras are enabled in lazyvim.json (or via :LazyExtras)
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- your own plugins and overrides
    { import = "plugins" },
  },
  defaults = { lazy = false, version = false },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false }, -- update manually with :Lazy update
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "zipPlugin" },
    },
  },
})
if not ok then
  fallback("lazy.nvim setup failed: " .. tostring(err))
end
