local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Create lsp autogroup
local lsp = vim.api.nvim_create_augroup('lsp', { clear = false })

-- I use a pattern of mappings which open in current window, split or vsplit
local function windowKeymaps(scope, callback, opts)
  local keys = { [scope] = false, s = 'split', v = 'vsplit' }
  for key, type in pairs(keys) do
    vim.keymap.set('n', '<leader>' .. scope .. key, function()
      if type then vim.cmd(type) end
      callback()
    end, opts)
  end
end

-- Supported LSPs
local servers = {
  'cssls',
  'dockerls',
  'docker_compose_language_service',
  'html',
  'jsonls',
  'pyright',
  'solidity_ls_nomicfoundation',
  'stylelint_lsp',
  'svelte',
  'tailwindcss',
  'ts_ls',
  'yamlls',
  -- TODO?
  -- "emmetls",
  -- "ruff_lsp",
  -- "stylelint_lsp",

  eslint = {
    -- The default configuration fetches the first encountered config when
    -- traversing up the file path. This causes user eslintrc's to be loaded if
    -- it exists on, for example, ~/.eslintrc.
    --
    -- The below adds a heuristic which does not search for eslint configs
    -- outside of the git repository root.
    root_dir = function(fname)
      local util = require 'lspconfig.util'

      local absolute_root =
          util.find_git_ancestor(fname) or
          util.find_node_modules_ascestor(fname) or
          '/'
      local root_file = util.insert_package_json({
        '.eslintrc',
        '.eslintrc.js',
        '.eslintrc.cjs',
        '.eslintrc.yaml',
        '.eslintrc.yml',
        '.eslintrc.json',
        'eslint.config.js',
        'eslint.config.mjs',
        'eslint.config.cjs',
        'eslint.config.ts',
        'eslint.config.mts',
        'eslint.config.cts',
      }, 'eslintConfig', fname)

      for _, name in ipairs(root_file) do
        local root_dir = util.root_pattern(name)(fname)
        if util.path.is_descendant(absolute_root, root_dir) then
          return root_dir
        end
      end

      return nil
    end,
  },

  graphql = {
    filetypes = { "graphql", "typescript", "javascript", "typescriptreact", "javascriptreact" }
  },

  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = { enable = false },
      },
    },
  },

  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = { diagnostics = { enable = true } }
    }
  },
}

return {
  'neovim/nvim-lspconfig',

  init = function()
    local lspconfig = require('lspconfig')

    -- Set up server configs
    for name, config in pairs(servers) do
      if type(config) == 'string' then
        name = config
        config = {}
      end

      local server = vim.tbl_deep_extend(
        'force',
        { capabilities = capabilities },
        config
      )

      lspconfig[name].setup(server)
    end

    -- Let floating windows have rounded borders
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or 'rounded'
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then return end

        -- Enable completion triggered by <c-x><c-o>
        if client.server_capabilities.completionProvider then
          vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', {
            buf = args.buf,
          })
        end

        -- Buffer local mappings.
        local opts = { buffer = args.buf, noremap = true, silent = true }

        if
            client.server_capabilities.definitionProvider or
            client.server_capabilities.workspaceSymbolProvider
        then
          vim.api.nvim_set_option_value('tagfunc', 'v:lua.vim.lsp.tagfunc', {
            buf = args.buf,
          })
        end

        if client.server_capabilities.codeActionProvider then
          vim.keymap.set({ 'n', 'v' }, '<leader>aa', vim.lsp.buf.code_action, opts)
        end

        if client.server_capabilities.declarationProvider then
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        end

        if client.server_capabilities.definitionProvider then
          windowKeymaps('d', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        end

        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd('CursorHold', {
            buffer = args.buf,
            group = lsp,
            callback = function() vim.lsp.buf.document_highlight() end,
          })

          vim.api.nvim_create_autocmd('CursorHoldI', {
            buffer = args.buf,
            group = lsp,
            callback = function() vim.lsp.buf.document_highlight() end,
          })

          vim.api.nvim_create_autocmd('CursorMoved', {
            buffer = args.buf,
            group = lsp,
            callback = function() vim.lsp.buf.clear_references() end,
          })
        end

        if client.server_capabilities.hoverProvider then
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        end

        if client.server_capabilities.implementationProvider then
          windowKeymaps('i', vim.lsp.buf.implementation, opts)
        end

        if client.server_capabilities.signatureHelpProvider then
          vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
        end

        if client.server_capabilities.referencesProvider then
          vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, opts)
        end

        if client.server_capabilities.renameProvider then
          vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, opts)
        end
      end
    })
  end,
}
