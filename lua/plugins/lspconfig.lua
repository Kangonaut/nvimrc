local servers = {
  -- Lua
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },

  -- Python
  pyright = {},
}

local tools = {
  -- Lua
  "stylua",

  -- Python
  "black",

  -- Spelling
  "codespell",

  -- Markdown
  "markdownlint",
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        -- [[ mason.nvim ]]
        -- desc: package manager for installing LSP (Language Server Protocol) server, DAP (Debug Adapter Protocol) servers, linters and formatters
        -- repo: https://github.com/williamboman/mason.nvim
        "williamboman/mason.nvim",
        config = true,
      },
      {
        -- [[ mason-lspconfig.nvim ]]
        -- desc: extension to mason.nvim that makes it easier to use with lspconfig
        -- repo: https://github.com/williamboman/mason-lspconfig.nvim
        "williamboman/mason-lspconfig.nvim",
      },
      {
        -- [[ mason-tool-installer.nvim ]]
        -- desc: install and upgrade third party tools automatically
        -- repo: https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
        "WhoIsSethDaniel/mason-tool-installer.nvim",
      },
      {
        -- [[ fidget.nvim ]]
        -- desc: UI for LSP progress
        -- repo: https://github.com/j-hui/fidget.nvim
        "j-hui/fidget.nvim",
        opts = {},
      },
      {
        -- [[ nodev.nvim ]]
        -- desc: configures Lua LSP for Neovim
        -- repo: https://github.com/folke/neodev.nvim
        "folke/neodev.nvim",
        opts = {},
      },
    },
    config = function()
      -- [[ configure what happens when LSP attaches ]]
      -- triggered when an LSP attaches to a particular buffer
      -- this happens when the file is associated with an LSP server
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local builtin = require("telescope.builtin")

          -- [[ configure keymaps ]]
          -- goto's
          vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "[d]efinition" })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[D]efinition" })
          vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[r]eferences" })
          vim.keymap.set("n", "gI", builtin.lsp_implementations, { desc = "[I]mplementations" })
          vim.keymap.set("n", "gy", builtin.lsp_type_definitions, { desc = "t[y]pe definition" })

          -- symbols
          vim.keymap.set("n", "<leader>cs", builtin.lsp_document_symbols, { desc = "[s]ymbols (current buffer)" })
          vim.keymap.set("n", "<leader>cS", builtin.lsp_dynamic_workspace_symbols, { desc = "[S]ymbols (entire workspace)" })

          -- code actions
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[r]ename" })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[a]ctions" })

          -- documentation
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover documentation" })

          -- [[ configure autocommands ]]
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- configure format on save
          if client and client.supports_method("textDocument/formatting") then
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            local bufnr = vim.tbl_keys(client.attached_buffers)[0]

            vim.api.nvim_clear_autocmds({
              group = augroup,
              buffer = bufnr,
            })

            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end

          -- highlight references of the word under your cursor when it rests there for a little while
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

            -- highlight references
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            -- clear references when cursor moves again
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,

              callback = vim.lsp.buf.clear_references,
            })

            -- clear highlights and autocommands when the LSP server detaches
            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          -- enable inlay hints
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.keymap.set("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, { desc = "[t]oggle inlay [h]ints" })
          end
        end,
      })

      -- [[ configure LSP ]]
      -- extend Neovim's basic capabilities with those that come with nvim-cmp, luasnip, ...
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- setup mason
      require("mason").setup()

      -- build ensure installed from server table
      local ensure_installed = vim.tbl_keys(servers or {})

      -- extend ensure_installed by tools
      vim.list_extend(ensure_installed, tools)

      -- setup mason-tool-installer
      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
      })

      -- setup mason-lspconfig
      require("mason-lspconfig").setup({
        handlers = {
          -- configure LSP servers
          function(server_name)
            -- retrieve the custom server config
            local server = servers[server_name] or {}

            -- extend default capabilities
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

            -- setup LSP server
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
