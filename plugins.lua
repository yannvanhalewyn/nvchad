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
      local parpar = require("parpar")
      local map = function(lhs, f)
        vim.keymap.set("i", lhs, f, { noremap = true, silent = true })
      end
      map("<A-H>", parpar.wrap(paredit.api.slurp_backwards))
      map("<A-J>", parpar.wrap(paredit.api.barf_backwards))
      map("<A-K>", parpar.wrap(paredit.api.barf_forwards))
      map("<A-L>", parpar.wrap(paredit.api.slurp_forwards))

      -- Fix J breaking multiline sexps
      -- https://github.com/gpanders/nvim-parinfer/issues/11
      vim.keymap.set("n", "J", "A<space><esc>J", { noremap = true, silent = true })

			parpar.setup({
				-- TODO move to other file
				-- parinfer = {
				-- 	keys = {
				-- 		["p"] = {
				-- 			function()
				-- 				vim.schedule(parpar.pause())
				-- 				vim.cmd("norm p")
				-- 			end
				-- 		}
				-- 	}
				-- },
				paredit = {
					keys = {
            -- Not working
						["<A-H>"] = { paredit.api.slurp_backwards, "Slurp backwards" },
						["<A-J>"] = { paredit.api.barf_backwards, "Barf backwards" },
						["<A-K>"] = { paredit.api.barf_forwards, "Barf forwards" },
						["<A-L>"] = { paredit.api.slurp_forwards, "Slurp forwards" },
						["<localleader>w"] = {
							function()
								-- place cursor and set mode to `insert`
								paredit.cursor.place_cursor(
									-- wrap element under cursor with `( ` and `)`
									paredit.wrap.wrap_element_under_cursor("( ", ")"),
									-- cursor placement opts
									{ placement = "inner_start", mode = "insert" }
								)
							end,
							"Wrap element insert head",
						},

						["<localleader>W"] = {
							function()
								paredit.cursor.place_cursor(
									paredit.wrap.wrap_element_under_cursor("(", ")"),
									{ placement = "inner_end", mode = "insert" }
								)
							end,
							"Wrap element insert tail",
						},

						-- same as above but for enclosing form
						["<localleader>i"] = {
							function()
								paredit.cursor.place_cursor(
									paredit.wrap.wrap_enclosing_form_under_cursor("( ", ")"),
									{ placement = "inner_start", mode = "insert" }
								)
							end,
							"Wrap form insert head",
						},

						["<localleader>I"] = {
							function()
								paredit.cursor.place_cursor(
									paredit.wrap.wrap_enclosing_form_under_cursor("(", ")"),
									{ placement = "inner_end", mode = "insert" }
								)
							end,
							"Wrap form insert tail",
						}
					}
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
    keys = {
      { "<leader>ha", function() require("harpoon"):list():append() end, desc = "Harpoon Add File" },
      {
        "<leader>H",
        function()
          require("harpoon").ui:toggle_quick_menu(
            require("harpoon"):list(),
            { border = "rounded", title_pos = "center" }
          )
        end,
        desc = "Harpoon Quick Menu"
      },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon Browse File (1)" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon Browse File (2)" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon Browse File (3)" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon Browse File (4)" },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon Browse File (5)" },
      { "<leader>6", function() require("harpoon"):list():select(6) end, desc = "Harpoon Browse File (6)" },
      { "<leader>7", function() require("harpoon"):list():select(7) end, desc = "Harpoon Browse File (7)" },
      { "<leader>8", function() require("harpoon"):list():select(8) end, desc = "Harpoon Browse File (8)" },
      { "<leader>9", function() require("harpoon"):list():select(9) end, desc = "Harpoon Browse File (9)" },
      { "<leader>0", function() require("harpoon"):list():select(10) end, desc = "Harpoon Browse File (10)" },
      { "<A-p>", function() require("harpoon"):list():prev() end, desc = "Harpoon Next" },
      { "<A-n>", function() require("harpoon"):list():next() end, desc = "Harpoon Prev" },
    },
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
    keys = {
      { "<leader>gg", function() require("neogit").open() end, "Open Neogit" }
    },
    config = true
  },

  {
    "emmanueltouzery/agitator.nvim",
    keys = {
      {
        "<leader>gB",
        function()
          require("agitator").git_blame_toggle({
            -- formatter= function(r)
            --   return r.author .. " => " .. r.summary;
            -- end
          })
        end
      },
      {
        "<leader>gf",
        function()
          require("agitator").open_file_git_branch()
        end
      },
      {
        "<leader>gt",
        function()
          require("agitator").git_time_machine()
        end
      }
    }
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
      { "[t", function() require("trouble").previous({skip_groups = false, jump = true}) end, "Trouble Prev" },
      { "]t", function() require("trouble").next({skip_groups = true, jump = true}) end, "Trouble Next" },
      { "<leader>tt", function() require("trouble").toggle() end, "Trouble Toggle" },
      {
        "<leader>tr",
        function() require("trouble").toggle("lsp_references") end,
        "Trouble References"
      },
      {
        "<leader>fe",
        function() require("trouble").toggle("document_diagnostics") end,
        "Trouble Document Diagnostics"
      },
      {
        "<leader>fE",
        function() require("trouble").toggle("workspace_diagnostics") end,
        "Trouble Workspace Diagnostics"
      },
      {
        "<leader>tQ",
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
    keys = {
      { "gt", "<cmd>TodoQuickFix<CR>", desc = "TODOs quickfix" },
      { "gT", "<cmd>TodoTrouble<CR>", desc = "TODOs trouble" },
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "TODOs search" },
    }
  },
  {
    "RRethy/vim-illuminate",
    -- 16ms loading time, lazy load on clojure
    -- Consider using keys with a toggle
    ft = { "clojure" },
    keys = {
      {
        "[r",
        function()
          require("illuminate").goto_prev_reference()
          -- vim.api.nvim_feedkeys("zz", "n", false)
        end,
        "Illuminate: Goto next reference"
      },
      {
        "]r",
        function()
          require("illuminate").goto_next_reference()
          -- vim.api.nvim_feedkeys("zz", "n", false)
        end,
        "Illuminate: Goto next reference"
      },
    }
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
    -- ~2ms, not worth lazy loading
    lazy = false,
    config = function ()
      require("neoscroll").setup({
        mappings = {"C-u", "C-d", "C-b", "C-f", "C-y", "C-e"},
        performance_mode = false
      })
      local t = {}
      local speed = "50"
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
    keys = {
      { "<leader>bd", "<cmd>BD<CR>", "Kill Buffer" },
      { "<leader>bD", "<cmd>BD!<CR>", "Kill Buffer" },
      -- Better switching buffers. Default :bprev and :bnext get confused with
      -- Conjure Log buffers and netrw buffers
      { "[b", "<cmd>BB<CR>", "Prev Buffer" },
      { "]b", "<cmd>BF<CR>", "Next Buffer" },
    },
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
    enabled = false,
  },
  {
    "NvChad/nvterm",
    enabled = false
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    keys = {
      { "<leader>n", "<cmd>NvimTreeToggle<CR>", "NvimTree" }
    },
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
