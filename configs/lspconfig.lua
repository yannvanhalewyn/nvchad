local config = require("plugins.configs.lspconfig")

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "clojure_lsp", "lua_ls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_init = config.on_init,
    on_attach = config.on_attach,
    capabilities = config.capabilities,
  }
end

--
-- lspconfig.pyright.setup { blabla}
