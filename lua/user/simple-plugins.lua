local M = {
  -- Colorscheme
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "nordfox"
    end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    config = function()
      require "nvim-web-devicons"
    end,
  },

  -- Schema store
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {
        check_ts = true,
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
      }
    end,
  },

  -- Arrow navigation
  {
    "otavioschwanck/arrow.nvim",
    config = function()
      require("arrow").setup {
        show_icons = true,
        leader_key = ";",
        buffer_leader_key = "m",
      }
    end,
  },

  -- Buffer delete
  {
    "famiu/bufdelete.nvim",
    config = function()
      local wk = require "which-key"
      wk.add {
        { "<leader>bc", "<cmd>Bdelete!<CR>", desc = "Close Buffer" },
      }
    end,
  },

  -- Breadcrumbs
  {
    "LunarVim/breadcrumbs.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    config = function()
      require("breadcrumbs").setup()
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          ignore_focus = { "NvimTree" },
        },
        extensions = { "quickfix", "man", "fugitive" },
      }
    end,
  },
}

return M
