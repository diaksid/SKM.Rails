User.create! YAML.load_file 'db/seeds/users.yml' if User.all.empty?

YAML.load_file('db/seeds/areas.yml').each_with_index do |model, idx|
  Area.create! model.merge!({active: true})
end if Area.all.empty?

YAML.load_file('db/seeds/activities.yml').each do |model|
  area_ids = model.delete 'area_ids'
  model = Activity.create! ({
    published: true,
    navigated: true,
    content: '...'
  }).merge model
  model.area_ids = area_ids if area_ids
end if Activity.all.empty?

YAML.load_file('db/seeds/customers.yml').each do |model|
  Customer.create! ({
    active: true,
    published: true,
    navigated: true
  }).merge model
end if Customer.all.empty?

YAML.load_file('db/seeds/targets.yml').each do |model|
  Target.create! ({
    published: true,
    navigated: true
  }).merge model
end if Target.all.empty?

YAML.load_file('db/seeds/articles.yml').each do |model|
  Article.create! ({
    published: true,
    navigated: true
  }).merge model
end if Article.all.empty?
