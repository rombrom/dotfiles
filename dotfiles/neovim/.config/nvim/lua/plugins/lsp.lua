-- Ceate lsp autogroup
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
  'eslint',
  'html',
  'jsonls',
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

  standardrb = {
    cmd = { 'mise', 'x', '--', 'standardrb', '--lsp' },
  },

  ruby_lsp = {
    cmd = { 'mise', 'x', '--', 'ruby-lsp' },
    init_options = {
      formatter = 'standard',
      linters = { 'standard' },
      addonSettings = {
        ["Ruby LSP Rails"] = {
          enablePendingMigrationsPrompt = false,
        },
      },
    },
  },
}

return {
  'neovim/nvim-lspconfig',

  init = function()
    local has_blink, blink = pcall(require, 'blink.cmp')

    -- Set up server configs
    for name, config in pairs(servers) do
      if type(config) == 'string' then
        name = config
        config = {}
      end

      -- Tack on blink capabilities
      if has_blink then
        config.capabilities = blink.get_lsp_capabilities(config.capabilities)
      end

      vim.lsp.config(name, config)
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.lsp.enable(name)
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

        if client.server_capabilities.codeActionProvider then
          vim.keymap.set({ 'n', 'v' }, '<leader>aa', vim.lsp.buf.code_action, opts)
        end

        if client.server_capabilities.declarationProvider then
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        end

        if client.server_capabilities.definitionProvider then
          vim.api.nvim_set_option_value('tagfunc', 'v:lua.vim.lsp.tagfunc', {
            buf = args.buf,
          })
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          windowKeymaps('d', vim.lsp.buf.definition, opts)
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
