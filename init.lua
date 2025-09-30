require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require('lazy').setup {
    require 'plugins.colortheme',
    require 'plugins.treesitter',
    require 'plugins.harpoon',
    require 'plugins.telescope',
    require 'plugins.comment',
    require 'plugins.misc',
}


local function safe_format(cmd)
  return function()
    local view = vim.fn.winsaveview()
    local buf = vim.api.nvim_get_current_buf()
    local content = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    local output = vim.fn.systemlist(cmd, content)

    if vim.v.shell_error == 0 then
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
    else
      vim.notify("Formatter failed: " .. cmd, vim.log.levels.ERROR)
    end

    vim.fn.winrestview(view)
  end
end

-- Usage
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = safe_format("goimports"),
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  callback = safe_format("clang-format"),
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = safe_format("black -q -"),
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {
    "*.html",
    "*.css",
    "*.scss",
    "*.js",
    "*.jsx",
    "*.ts",
    "*.tsx",
    "*.json",
    "*.md",
    "*.yaml",
    "*.yml",
  },
  callback = function()
    local filepath = vim.fn.expand("%:p") -- expand full file path
    safe_format("prettier --stdin-filepath " .. vim.fn.shellescape(filepath))()
  end,
})
