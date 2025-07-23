local M = {
  "folke/which-key.nvim",
}

M.opts = {
  win = {
    padding = { 2, 2 },
  },
}

function M.config()
  local mappings = {
    { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
    { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight" },
    { "<leader>w", "<cmd>lua vim.wo.wrap = not vim.wo.wrap<CR>", desc = "Wrap" },
    { "<leader>;", "<cmd>tabnew | terminal<CR>", desc = "Term" },
    { "<leader>v", "<cmd>vsplit<CR>", desc = "Split" },
    { "<leader>b", group = "Buffers" },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "LSP" },
    { "<leader>p", group = "Plugins" },
    { "<leader>r", group = "Rest" },
    { "<leader>s", group = "Test" },
    { "<leader>t", group = "Tab" },
    { "<leader>tn", "<cmd>$tabnew<CR>", desc = "New Empty Tab" },
    { "<leader>tN", "<cmd>tabnew %<CR>", desc = "New Tab" },
    { "<leader>to", "<cmd>tabonly<CR>", desc = "Only" },
    { "<leader>th", "<cmd>tabp<CR>", desc = "Previous Tab" },
    { "<leader>tl", "<cmd>tabn<CR>", desc = "Next Tab" },
    { "<leader>tH", "<cmd>-tabmove<CR>", desc = "Move Left" },
    { "<leader>tL", "<cmd>+tabmove<CR>", desc = "Move Right" },
    { "<leader>T", group = "Treesitter" },
  }

  local wk = require "which-key"

  wk.add(mappings)
end

return M
