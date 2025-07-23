local M = {
  "rest-nvim/rest.nvim",
  ft = "http",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "http")
    end,
  },
}

function M.config()
  vim.g.rest_nvim = {
    response = {
      hooks = {
        format = true,
      }
    },
  }
  
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    callback = function()
      vim.bo.formatprg = "jq ."
    end,
  })

  local wk = require "which-key"

  wk.add {
    { "<leader>rr", "<cmd>Rest run<CR>",     desc = "Run request" },
    { "<leader>rl", "<cmd>Rest last<CR>",    desc = "Run last request" },
    { "<leader>ro", "<cmd>Rest open<CR>",    desc = "Open result pane" },
    { "<leader>rg", "<cmd>Rest logs<CR>",    desc = "Edit logs" },
    { "<leader>rc", "<cmd>Rest cookies<CR>", desc = "Edit cookies" },
  }
end

return M
