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

-- Autosave: write modified file buffers 1 s after edits stop, and right away
-- on leaving the buffer or losing focus. Autosaves skip LazyVim's format-on-save
-- (explicit :w still formats), so autosave never reformats code under review.
local function autosave(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local bo = vim.bo[buf]
  if not vim.api.nvim_buf_is_valid(buf) or not bo.modified or bo.buftype ~= "" or bo.readonly
    or not bo.modifiable or vim.api.nvim_buf_get_name(buf) == "" then
    return
  end
  local prev = vim.g.autoformat
  vim.g.autoformat = false
  vim.api.nvim_buf_call(buf, function()
    vim.cmd("silent! lockmarks update")
  end)
  vim.g.autoformat = prev
end

local save_timer = (vim.uv or vim.loop).new_timer()
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  group = group,
  callback = function(ev)
    save_timer:stop()
    save_timer:start(1000, 0, vim.schedule_wrap(function()
      if vim.fn.mode() ~= "i" then
        autosave(ev.buf)
      end
    end))
  end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "VimLeavePre" }, {
  group = group,
  callback = function(ev)
    autosave(ev.buf)
  end,
})
