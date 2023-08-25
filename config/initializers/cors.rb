
Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://festivappcircus.com'  # Reemplaza con tu propio dominio
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
  end
  