activate :livereload

activate :sprockets do |c|
  c.imported_asset_path = "assets"
end

configure :build do
  activate :minify_css
  activate :minify_javascript
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.deploy_method = :git
  deploy.branch = 'gh-pages'
end

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end
