Slim::Engine.set_options format: :html, pretty: false, sort_attrs: false, shortcut: {
  '#' => {attr: 'id'},
  '.' => {attr: 'class'},
  '&' => {attr: 'type'},
  '@' => {attr: 'role'},
  '%' => {attr: 'itemprop'},
  '^' => {tag: 'span', attr: 'class', additional_attrs: {class: 'icon', 'aria-hidden': 'true'}}
}
