Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

# redis://default:a79bda0a29b6414e902e8799ea04701b@fly-sneaker-api-redis-00.upstash.io:6379

