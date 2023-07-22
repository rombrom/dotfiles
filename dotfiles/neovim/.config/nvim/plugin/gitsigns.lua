local ok, module = pcall(require, 'gitsigns')

if not ok then
  print('Error loading "gitsigns".')
  return
end

module.setup {}
