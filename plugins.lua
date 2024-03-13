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
    opts = overrides.telescope,
    dependencies = { "BurntSushi/ripgrep" }
  },

  -- Hook vim.ui.select into Telescope. Makes things like code actions work with Telescope.
  "nvim-telescope/telescope-ui-select.nvim",

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
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
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp
  },

  -- Clojure
  {
    "Olical/conjure",
    ft = { "clojure" },
    -- lazy = false, -- Break on eval if lazy
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
      local parpar = require("parpar")
			parpar.setup({
				paredit = {
					keys = require("custom.mappings").paredit["n"]
				}
			})
    end
  },

  {
    "ixru/nvim-markdown",
    ft = "markdown"
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "tpope/vim-surround",
    lazy = false,
  },
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
    end
  },

  -- Neogit dependency we don't use
  {
    "ibhagwan/fzf-lua",
    enabled = false
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim", -- optional
      "nvim-telescope/telescope.nvim",
    },
    config = true
  },
  {
    "emmanueltouzery/agitator.nvim",
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle"
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      position = "bottom",
      height = 20,
      width = 100,
      group = true
    }
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        -- Don't highlight rest of TODO body
        after = "",
        -- No need for semicolon
        pattern = [[.*<(KEYWORDS)\s*]],
      },
      search = {
        pattern = [[\b(KEYWORDS)]]
      }
    },
  },
  {
    "RRethy/vim-illuminate",
    -- 16ms loading time, lazy load on clojure
    -- Consider using keys with a toggle
    ft = { "clojure", "lua" }
  },
  {
    "nvim-treesitter/playground",
    keys = require("custom.mappings").treesitter_playground["n"]
  },
  {
    "karb94/neoscroll.nvim",
    enabled = not vim.g.neovide,
    -- ~2ms, not worth lazy loading
    lazy = false,
    config = function ()
      local mappings = require("custom.mappings").neoscroll["n"]
      require("neoscroll").setup({
        performance_mode = false
      })
      require('neoscroll.config').set_mappings(mappings)
    end
  },
  {
    "tpope/vim-repeat",
    lazy = false
  },
  {
    "tpope/vim-vinegar",
    lazy = false,
    config = function()
      -- vim.g.netrw_menu = 1
      vim.g.netrw_banner = 1
    end
  },
  -- Kill buffer without closing window...
  {
    "qpkorr/vim-bufkill",
    lazy = false,
    init = function()
      vim.g.BuffKillCreateMappings = 0
      vim.g.BufKillActionWhenBufferDisplayedInAnotherWindow = "kill"
    end
  },

  -- Disabled NVChad plugins
  {
    "folke/which-key.nvim",
    -- Consider only disabling operators plugin, as it opens up when doing 'c2'
    -- for example.
    enabled = true,
  },
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
  {
    "NvChad/nvim-colorizer.lua",
    enabled = false
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false
  }
}

return plugins
