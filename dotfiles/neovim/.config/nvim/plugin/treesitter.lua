local ok, module = pcall(require, 'nvim-treesitter.configs')

if not ok then
  print('Error loading "nvim-treesitter.configs".')
  return
end

module.setup {
  auto_install = true,
  ensure_installed = {
    'awk',
    'bash',
    'comment',
    'css',
    'diff',
    'dockerfile',
    -- 'gitignore',
    -- 'git_config',
    -- 'git_rebase',
    -- 'gitattributes',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'python',
    'regex',
    'scss',
    'solidity',
    'sql',
    'terraform',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
  },
  highlight = { enable = true },
  sync_install = false,
}
