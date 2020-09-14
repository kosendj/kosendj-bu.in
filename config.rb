activate :livereload

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.deploy_method = :git
  deploy.branch = 'gh-pages'
end

activate :external_pipeline,
  name: :sass,
  command: build? ? 'yarn run build' : 'yarn run watch',
  source: ".tmp",
  latency: 1
