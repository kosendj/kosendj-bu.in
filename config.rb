activate :livereload, js_host: ENV['JS_HOST']

activate :external_pipeline,
  name: :sass,
  command: build? ? 'pnpm run build' : 'pnpm run watch',
  source: ".tmp",
  latency: 1
