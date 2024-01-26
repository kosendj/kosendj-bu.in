activate :livereload, js_host: ENV['JS_HOST']

activate :external_pipeline,
  name: :sass,
  command: build? ? 'yarn run build' : 'yarn run watch',
  source: ".tmp",
  latency: 1
