vim.pack.add({ "https://github.com/ludovicchabant/vim-gutentags" })

vim.g.gutentags_file_list_command = {
  markers = { ['.git'] = 'git ls-files' }
}
