Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Change this to restrict the domains that can make requests to your Rails app.
    resource '*', # Change this to restrict the HTTP methods allowed.
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end