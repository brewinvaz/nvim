local M = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
}

M.build = function(plugin)
  if vim.fn.executable "npx" then
    vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
  else
    vim.cmd [[Lazy load markdown-preview.nvim]]
    vim.fn["mkdp#util#install"]()
  end
end

M.init = function()
  if vim.fn.executable "npx" then
    vim.g.mkdp_filetypes = { "markdown" }
  end
end

function M.config()
  local wk = require "which-key"

  wk.add {
    { "<leader>m", "<cmd>MarkdownPreview<CR>", desc = "MD Preview", mode = { "n", "v" } },
  }
end

return M
