local M = {}

-- Get's called correctly and returns true for conjure
local is_conjure_buffer = function(lang)
  local buf_name = vim.fn.expand("%")
  if lang == "clojure" and string.find(buf_name, "conjure%-") then
    return true
  end
end

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "markdown",
    "markdown_inline",
    "clojure",
  },

  highlight = {
    -- disable = is_conjure_buffer
    additional_vim_regex_highlighting = false
  },

  markdown = {
    enable = true
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "prettier",
  },
}

local cmp = require "cmp"

M.cmp = {
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = nil,
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s", }),
  }),
}

local function open_with_trouble()
  require("trouble.providers.telescope").open_with_trouble()
end

M.telescope = {
  extensions_list = { "themes", "terms","ui-select", "file_browser" },
  defaults = {
    mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    },
  },


  -- defaults = {
  --   mappings = {
  --     i = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
  --     n = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
  --   },
  -- },

  extensions = {
    -- ["ui-select"] = {
    --   require("telescope.themes").get_ivy({})
    -- }
  }
}

-- -- git support in nvimtree
M.nvimtree = {
  git = {
    enable = false,
    ignore = false,
  },

  renderer = {
    highlight_git = false,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
