return {
  settings = {
    workingDirectories = { mode = "auto" },
    format = { enable = true },
    lint = { enable = true },
  },
  root_dir = function(fname)
    -- Find the nearest eslint config file starting from the current file
    local util = require("lspconfig").util
    return util.root_pattern(
      ".eslintrc.js",
      ".eslintrc.json",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      ".eslintrc",
      "eslint.config.js"
    )(fname)
  end,
  -- This is crucial for monorepos
  single_file_support = false,
}

