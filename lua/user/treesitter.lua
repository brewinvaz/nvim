local M = {
  "nvim-treesitter/nvim-treesitter",
  -- The `main` branch is the 1.0 rewrite: it drops `nvim-treesitter.configs`
  -- and requires the `tree-sitter` CLI to install parsers. Stay on `master`
  -- until this config is migrated to the new API.
  branch = "master",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

-- Compat shim for Neovim 0.12 + nvim-treesitter `master`.
--
-- nvim-treesitter master registers its predicates/directives with
-- `{ force = true, all = false }`, which used to make `match[capture_id]` a
-- single TSNode. Nvim 0.12 dropped the `all` option: matches are now *always*
-- `table<integer, TSNode[]>`. Master's handlers still treat the value as a
-- node, so e.g. markdown's `(#set-lang-from-info-string! @_lang)` passes a
-- plain table into `get_node_text()` and blows up with
--   treesitter.lua: attempt to call method 'range' (a nil value)
-- on every markdown buffer with a fenced code block.
--
-- Wrap `add_predicate`/`add_directive` so any handler still asking for the old
-- `all = false` semantics gets the last captured node per capture, as before.
-- Runs in `init` so it is installed before nvim-treesitter requires
-- `nvim-treesitter.query_predicates`.
--
-- Remove this once the config migrates to the `main` branch.
function M.init()
  local query = vim.treesitter.query
  if not (query and query.add_directive) then
    return
  end

  local function unwrap_match(match)
    local single = {}
    for id, nodes in pairs(match) do
      single[id] = type(nodes) == "table" and nodes[#nodes] or nodes
    end
    return single
  end

  for _, fname in ipairs { "add_predicate", "add_directive" } do
    local original = query[fname]
    query[fname] = function(name, handler, opts)
      if type(opts) == "table" and opts.all == false then
        local inner = handler
        handler = function(match, ...)
          return inner(unwrap_match(match), ...)
        end
      end
      return original(name, handler, opts)
    end
  end
end

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
