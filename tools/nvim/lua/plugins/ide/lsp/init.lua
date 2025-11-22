return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    require 'plugins.ide.lsp.fidget',

    -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    require 'plugins.ide.lsp.lazydev',

    -- Language specific
    -- 'tweekmonster/django-plus.vim',
    -- 'simrat39/rust-tools.nvim',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
        end

        -- Telescope pickers
        local builtin = require 'telescope.builtin'
        map('gd',  builtin.lsp_definitions,                                    '[G]oto [D]efinition')
        map('grt', builtin.lsp_type_definitions,                               '[T]ype Definition')
        map('grr',  builtin.lsp_references,                                    '[G]oto [R]eferences')
        map('grO', builtin.lsp_dynamic_workspace_symbols,                      'Workspace Symbols')
        map('gld', builtin.lsp_document_symbols,                               '[D]ocument [S]ymbols')

        -- Diagnostic mappings
        -- Managed by mini.bracketed
        -- map('[d',     vim.diagnostic.goto_prev,                                'Go to previous [D]iagnostic message')
        -- map(']d',     vim.diagnostic.goto_next,                                'Go to next [D]iagnostic message')
        map('<C-w>d', vim.diagnostic.open_float,                               'Show diagnostic [E]rror messages')

        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>lh', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, 'Toggle Inlay [H]ints')
        end

        -- Enable/Disable LSP
        map('<leader>le', vim.cmd.LspStart,                                    'Enable LSP')
        map('<leader>ld', vim.cmd.LspStop,                                     'Disable LSP')

      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd          (table): Override the default command used to start the server
    --  - filetypes    (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings     (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
      clangd = {},
      jdtls = {},
      pyright = {},
      rust_analyzer = {},
      ['eslint-lsp'] = {},
      prettier = {},
      texlab = {},
      -- ltex = { filetypes = { 'bib', 'tex' } },

      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu.
    require('mason').setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, { 'stylua', }) -- Used to format Lua code
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
