local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "bash",
      "comment",
      "css",
      "dockerfile",
      "dot",
      "eex",
      "elixir",
      "erlang",
      "go",
      "graphql",
      "heex",
      "html",
      "http",
      "java",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "prisma",
      "proto",
      "python",
      "regex",
      "ruby",
      "rust",
      "scala",
      "scss",
      "solidity",
      "svelte",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    }, 
    highlight = { enable = true },
    indent = { enable = true },
  }
end

return M
