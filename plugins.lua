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

  -- Clojure
  {
    "Olical/conjure",
    ft = { "clojure" },
    lazy = false, -- Break on eval if lazy
    config = function()
      -- vim.g["conjure#highlight#enabled"] = true
      vim.g.clojure_align_subforms = 1
      vim.g.clojure_fuzzy_indent_patterns = { "^with", "^def", "^let", "^assoc"}
    end
  },
  {
    "dundalek/parpar.nvim",
    ft = "clojure",
    dependencies = { "gpanders/nvim-parinfer", "julienvincent/nvim-paredit" },
    config = function()
      local paredit = require("nvim-paredit")
      require("parpar").setup {
        paredit = {
          keys = {
            ["<A-H>"] = { paredit.api.slurp_backwards, "Slurp backwards" },
            ["<A-J>"] = { paredit.api.barf_backwards, "Barf backwards" },
            ["<A-K>"] = { paredit.api.barf_forwards, "Barf forwards" },
            ["<A-L>"] = { paredit.api.slurp_forwards, "Slurp forwards" },
          }
        }
      }
    end
  },

  -- Markdown
  {
    "tadmccorkle/markdown.nvim",
    ft = "markdown", -- or 'event = "VeryLazy"'
    opts = {
      -- configuration here or empty for defaults
    },
    config = function()
      require("markdown").setup({
        on_attach = function()
          print("ATTACH")
        end
      })
    end
  },

  -- UI and utilities
  {
    "tpope/vim-surround",
    lazy = false,
  },
  {
    "theprimeagen/harpoon",
    keys = {
      { "<leader>ha", function() require("harpoon.mark").add_file() end, desc = "Harpoon Add File" },
      -- { "<leader>hh", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Quick Menu" },
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
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      position = "bottom",
      height = 20,
      width = 100,
      group = true
    },
    keys = {
      { "[t", function() require("trouble").previous({skip_groups = false, jump = true}); end, "Trouble Prev" },
      { "]t", function() require("trouble").next({skip_groups = true, jump = true}); end, "Trouble Next" },
      { "<leader>tt", function() require("trouble").toggle() end, "Trouble Toggle" },
      {
        "<leader>tr",
        function() require("trouble").toggle("lsp_references") end,
        "Trouble References"
      },
      {
        "<leader>td",
        function() require("trouble").toggle("document_diagnostics") end,
        "Trouble Document Diagnostics"
      },
      {
        "<leader>tD",
        function() require("trouble").toggle("workspace_diagnostics") end,
        "Trouble Workspace Diagnostics"
      },
      {
        "<leader>tq",
        function() require("trouble").toggle("quickfix") end,
        "Trouble Quickfix"
      },
      {
        "<leader>tl",
        function() require("trouble").toggle("loclist") end,
        "Trouble Loclist"
      },
    }
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- highlight = {
      --   pattern = [[<(KEYWORDS)]]
      -- },
      -- search = {
      --   pattern = [[\b(KEYWORDS)]]
      -- }
    },
    keys = {
      { "gt", "<cmd>TodoQuickFix<CR>", desc = "TODOs quickfix" },
      { "gT", "<cmd>TodoTrouble<CR>", desc = "TODOs trouble" },
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "TODOs search" },
    }
  },

  {
    "RRethy/vim-illuminate",
    lazy = false
  },
  {
    "nvim-treesitter/playground",
    keys = {
      { "<leader>ht",  "<cmd>TSHighlightCapturesUnderCursor<CR>", "Help Treesitter" } ,
      { "<leader>hT" , "<cmd>TSPlaygroundToggle<CR>", "Help Treesitter Playground" },
    }
  },
  {
    "karb94/neoscroll.nvim",
    enabled = not vim.g.neovide,
    lazy = false,
    config = function ()
      require("neoscroll").setup({
        mappings = {"C-u", "C-d", "C-b", "C-f", "C-y", "C-e"},
        performance_mode = false
      })
      local t = {}
      local speed = "150"
      t["<C-u>"] = {"scroll", {"-vim.wo.scroll", "true", speed}}
      t["<C-d>"] = {"scroll", {"vim.wo.scroll", "true", speed}}
      t["<C-b>"] = {"scroll", {"-vim.api.nvim_win_get_height(0)", "true", speed}}
      t["<C-f>"] = {"scroll", {"vim.api.nvim_win_get_height(0)", "true", speed}}
      t["<C-y>"] = {"scroll", {"-0.10", "false", speed}}
      t["<C-e>"] = {"scroll", { "0.10", "false", speed}}
      t["zt"]    = {"zt", { speed }}
      t["zz"]    = {"zz", { speed }}
      t["zb"]    = {"zb", { speed }}

      require('neoscroll.config').set_mappings(t)
    end

  },
  {
    "tpope/vim-repeat",
    lazy = false
  },
  {
    "tpope/vim-vinegar",
    lazy = false
  },
  -- Kill buffer without closing window...
  {
    "vim-scripts/bufkill.vim",
    lazy = false
  },

  -- Disabled NVChad plugins
  {
    "NvChad/nvterm",
    enabled = false
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    opts = overrides.nvimtree,
  },
  {
    "nvim-tree/nvim-web-devicons",
    -- Needed for nice trouble
    -- enabled = false
  },
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false
  }
}

return plugins
