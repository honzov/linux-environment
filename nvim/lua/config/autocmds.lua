-- Loaded on VeryLazy. LazyVim defaults:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
local group = vim.api.nvim_create_augroup("honza", { clear = true })

-- Trim trailing whitespace on save (port of TrimWhitespace from _vimrc)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  callback = function()
    if not vim.bo.modifiable or vim.bo.binary or vim.bo.filetype == "diff" then
      return
    end
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Reload buffers changed on disk (e.g. by Claude in another pane) without prompting.
local function checktime()
  if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
    vim.cmd("silent! checktime")
  end
end

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermLeave" }, {
  group = group,
  callback = checktime,
})

local timer = (vim.uv or vim.loop).new_timer()
timer:start(2000, 2000, vim.schedule_wrap(checktime))

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = group,
  callback = function(ev)
    vim.notify("Reloaded: " .. vim.fn.fnamemodify(ev.file, ":."), vim.log.levels.INFO)
  end,
})
