return {
  -- TODO: fix
  'mattn/emmet-vim',

  init = function()
    vim.g.user_emmet_leader_key = '<Leader><Leader>'
    vim.g.user_emmet_settings = {
      javascript = {
        extends = 'jsx',
      },
      typescript = {
        extends = 'tsx',
      },
    }
  end
}
