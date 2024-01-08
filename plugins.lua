local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require "custom.configs.none-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "python" },
    lazy = false,
  },
  {
    "tpope/vim-surround",
    lazy = false,
  },
  {
    "theprimeagen/harpoon",
    keys = {
      { "<leader>ha", function() require("harpoon.mark").add_file() end, desc = "Harpoon Add File" },
      { "<leader>hh", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Quick Menu" },
      { "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon Browse File (1)" },
      { "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon Browse File (2)" },
      { "<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon Browse File (3)" },
      { "<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon Browse File (4)" },
    },
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Undo Tree" }
    }
  },
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gg", vim.cmd.Git, desc = "Git" }
    }
  },
  {
    "nvim-treesitter/playground",
    lazy = false
  },

}

return plugins
