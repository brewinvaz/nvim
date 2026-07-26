return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
    config = function(_, opts)
      -- Disable ts_ls to avoid conflicts (e.g. if mason-lspconfig auto-enables it)
      vim.lsp.enable("ts_ls", false)


      require("typescript-tools").setup(opts)
      
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "typescript-tools" then
            for _, other_client in ipairs(vim.lsp.get_clients { bufnr = args.buf }) do
              if other_client.name == "ts_ls" then
                vim.lsp.buf_detach_client(args.buf, other_client.id)
              end
            end
          end
        end,
      })
    end,
  },
}
