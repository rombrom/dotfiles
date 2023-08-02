local ok, lspconfig = pcall(require, 'lspconfig')

if not ok then
  print('Error loading "lspconfig".')
  return
end

local ok, cmp = pcall(require, 'cmp_nvim_lsp')

if not ok then
  print('Error loading "cmp_nvim_lsp".')
end

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
local shared_config = {
  capabilities = cmp.default_capabilities(),
  on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = bufnr, noremap = true, silent = true }

    windowKeymaps('d', vim.lsp.buf.definition, opts)
    windowKeymaps('i', vim.lsp.buf.implementation, opts)

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>gR', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>sf', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end
}

-- Supported LSPs
local servers = {
  'cssls',
  'dockerls',
  'docker_compose_language_service',
  'graphql',
  'html',
  'jsonls',
  'pyright',
  'solidity_ls_nomicfoundation',
  'svelte',
  'tailwindcss',
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

  tsserver = {
    init_options = {
      completionDisableFilterText = true
    }
  }
}

-- Set up configuraiton for each LSP
for name, config in pairs(servers) do
  if type(config) == 'string' then
    name = config
    config = {}
  end

  lspconfig[name].setup(vim.tbl_extend('keep', config, shared_config))
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
