-- It's nutty but colorizer won't initialize in Packer's config param
require 'colorizer'.setup {
  user_default_options = {
    AARRGGBB = true,
    RGB = true,
    RRGGBB = true,
    RRGGBBAA = true,
    css_fn = true,
    mode = 'virtualtext',
    names = false,
    virtualtext = '◉',
  }
}
