Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5173/' # フロントエンドのオリジン

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
      credentials: false               # Cookie 認証が不要なら false
  end
end