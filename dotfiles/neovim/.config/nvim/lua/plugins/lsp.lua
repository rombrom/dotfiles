local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

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

-- LSP Configuration shared by all servers
-- @type lsxb
local shared_config = {
  capabilities = capabilities,
  on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', {
      buf = bufnr
    })

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = bufnr, noremap = true, silent = true }

    windowKeymaps('d', vim.lsp.buf.definition, opts)
    windowKeymaps('i', vim.lsp.buf.implementation, opts)

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>aa', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>sf', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end
}

-- Supported LSPs
local servers = {
  'cssls',
  'css_variables',
  'dockerls',
  'docker_compose_language_service',
  -- TODO
  -- 'emmet_ls',
  'eslint',
  'graphql',
  'html',
  'jsonls',
  'pyright',
  'solidity_ls_nomicfoundation',
  'svelte',
  'tailwindcss',
  'ts_ls',
  'yamlls',
  -- TODO?
  -- "emmetls",
  -- "eslint"
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

    for name, config in pairs(servers) do
      if type(config) == 'string' then
        name = config
        config = {}
      end

      local server = vim.tbl_deep_extend('force', {}, shared_config, config)

      lspconfig[name].setup(server)
    end

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or 'rounded'
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end
  end,

  keys = {
    { '[d',         vim.diagnostic.goto_prev },
    { ']d',         vim.diagnostic.goto_next },
    { '<leader>dk', vim.diagnostic.open_float },
    { '<leader>dq', vim.diagnostic.setqflist },
  }
}
