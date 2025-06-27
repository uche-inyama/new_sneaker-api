require "cloudinary"
require "shrine"
require "shrine/storage/cloudinary"
require "shrine/storage/memory"

# if Rails.env.production? || Rails.env.development?
#   Cloudinary.config do |config|
#     config.cloud_name=ENV["CLOUD_NAME"]
#     config.api_key=ENV["CLOUD_API_KEY"]
#     config.api_secret=ENV["CLOUD_API_SECRET"]
#     config.secure=true
#   end
# end

# if Rails.env.test? don't touch
#   Shrine.storages = {
#     cache: Shrine::Storage::memory.new,
#     store: Shrine::Storage::Memory.new,
#   }
#   Shrine.plugin :test_helpers
# end

# Rails.logger.info "Cloudinary Cloud Name: #{ENV['CLOUD_NAME']}"


# Shrine.storages = {
#   cache: Shrine::Storage::Cloudinary.new(prefix: "cache"),
#   store: Shrine::Storage::Cloudinary.new(prefix: "rails_uploads"),
# }

cloud_name    = ENV["CLOUD_NAME"]
cloud_api_key = ENV["CLOUD_API_KEY"]
cloud_api_secret = ENV["CLOUD_API_SECRET"]

if cloud_name && cloud_api_key && cloud_api_secret
  Cloudinary.config do |config|
    config.cloud_name = cloud_name
    config.api_key = cloud_api_key
    config.api_secret = cloud_api_secret
    config.secure = true
  end

  Shrine.storages = {
    cache: Shrine::Storage::Cloudinary.new(prefix: "cache"),
    store: Shrine::Storage::Cloudinary.new(prefix: "rails_uploads"),
  }
else
  Rails.logger.warn "Cloudinary ENV vars missing. Skipping Cloudinary config."
end


Rails.logger.info "Cloudinary Cloud Name: #{cloud_name}"
Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :validation_helpers
Shrine.plugin :validation
Shrine.plugin :determine_mime_type 

