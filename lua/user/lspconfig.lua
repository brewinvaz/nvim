local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      -- neodev.nvim is archived and only hooks the removed `lspconfig`
      -- framework; lazydev works with `vim.lsp.config`.
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set

  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  keymap("n", "gd", vim.lsp.buf.definition, opts)
  -- `vim.lsp.with()` is deprecated; pass the border to the buf function instead
  keymap("n", "K", function()
    vim.lsp.buf.hover { border = "rounded" }
  end, opts)
  keymap("n", "gI", vim.lsp.buf.implementation, opts)
  keymap("n", "gr", vim.lsp.buf.references, opts)
  keymap("n", "gs", function()
    vim.lsp.buf.signature_help { border = "rounded" }
  end, opts)
  keymap("n", "gl", vim.diagnostic.open_float, opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  if client:supports_method "textDocument/inlayHint" then
    -- disable hints on_attach
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

M.toggle_inlay_hints = function()
  local bufnr = vim.api.nvim_get_current_buf()

  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
end

function M.config()
  local wk = require "which-key"

  wk.add {
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action", mode = { "n", "v" } },
    {
      "<leader>lf",
      "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
      desc = "Format",
    },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
    { "<leader>lj", "<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<CR>", desc = "Next Diagnostic" },
    { "<leader>lh", "<cmd>lua require('user.lspconfig').toggle_inlay_hints()<CR>", desc = "Hints" },
    { "<leader>lk", "<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<CR>", desc = "Prev Diagnostic" },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", desc = "CodeLens Action" },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "Quickfix" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
  }

  local servers = require "user.lspservers"
  local icons = require "user.icons"

  local default_diagnostic_config = {
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
      },
    },
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = true,
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(default_diagnostic_config)

  for _, server in pairs(servers) do
    -- Skip ts_ls since we're using typescript-tools
    if server ~= "ts_ls" then
      local opts = {
        on_attach = M.on_attach,
        capabilities = M.common_capabilities(),
      }

      local require_ok, settings = pcall(require, "user.lspsettings." .. server)

      if require_ok then
        opts = vim.tbl_deep_extend("force", settings, opts)
      end

      -- `require("lspconfig")` is deprecated: nvim-lspconfig now only ships
      -- `lsp/<server>.lua` defaults that these calls extend and turn on.
      vim.lsp.config(server, opts)
      vim.lsp.enable(server)
    end
  end
end

return M
