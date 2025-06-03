activate :livereload, js_host: ENV['JS_HOST']

activate :external_pipeline,
  name: :sass,
  command: build? ? 'pnpm run build' : 'pnpm run watch',
  source: ".tmp",
  latency: 1

# Ignore the source scss files since they're handled by external pipeline
ignore 'stylesheets/*.scss'
ignore 'stylesheets/_*.scss'
