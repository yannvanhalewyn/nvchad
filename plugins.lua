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

      vim.diagnostic.config({
        virtual_text = false,
      })

      -- vim.api.nvim_create_autocmd("CursorHold", {
      --   pattern = "*",
      --   callback = function(args)
      --     vim.diagnostic.open_float()
      --   end
      -- })
    end, -- Override to setup mason-lspconfig
  },
  {
    "nvim-telescope/telescope.nvim",
    -- needed for ui-select to attach to vim.ui
    lazy = false,
    opts = overrides.telescope
  },

  -- Hook vim.ui.select into Telescope. Makes things like code actions work with Telescope.
  "nvim-telescope/telescope-ui-select.nvim",

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
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp
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
      { "<leader>H", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Quick Menu" },
      { "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon Browse File (1)" },
      { "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon Browse File (2)" },
      { "<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon Browse File (3)" },
      { "<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon Browse File (4)" },
      { "<leader>5", function() require("harpoon.ui").nav_file(5) end, desc = "Harpoon Browse File (5)" },
      { "<leader>6", function() require("harpoon.ui").nav_file(6) end, desc = "Harpoon Browse File (6)" },
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
    "julienvincent/nvim-paredit",
    lazy = false,
    config = function()
      require("nvim-paredit").setup({ indent = { enabled = true } })
    end
  },

  {
    "nvim-treesitter/playground",
    lazy = false
  },

  {
    "RRethy/vim-illuminate",
    lazy = false
  }
}

return plugins
