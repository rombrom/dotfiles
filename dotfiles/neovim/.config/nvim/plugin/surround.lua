local ok, module = pcall(require, 'nvim-surround')

if not ok then
  print('Error loading "nvim-surround".')
  return
end

module.setup {}
