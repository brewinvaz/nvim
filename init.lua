require "user.autocmds"
require "user.launch"
require "user.keymaps"
require "user.options"

-- Plugins
spec "user.alpha"
spec "user.autopairs"
spec "user.breadcrumbs"
spec "user.bufdelete"
spec "user.cmp"
spec "user.colorscheme"
spec "user.gitsigns"
spec "user.harpoon"
spec "user.lspconfig"
spec "user.lualine"
spec "user.markdown-preview"
spec "user.mason"
spec "user.navic"
spec "user.none-ls"
spec "user.nvimtree"
spec "user.project"
spec "user.schemastore"
spec "user.telescope"
spec "user.treesitter"
spec "user.ufo"
spec "user.whichkey"

-- Extras
spec "user.extras.codeium"
spec "user.extras.eyeliner"
spec "user.extras.gitlinker"
spec "user.extras.illuminate"
spec "user.extras.neogit"
spec "user.extras.neoscroll"
spec "user.extras.neotab"
spec "user.extras.oil"
spec "user.extras.tabby"

-- Initialize lazy after the plugin table is defined
require "user.lazy"
