-- from: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
local M = {}

M.project_files = function()
  local opts = { show_untracked = true }
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then
      require"telescope.builtin".find_files(opts)
  end
end

return M
