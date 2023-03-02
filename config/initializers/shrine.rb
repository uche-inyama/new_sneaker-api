require "cloudinary"
require "shrine/storage/cloudinary"

Cloudinary.config(
  cloud_name: ENV["CLOUD_NAME"],
  api_key:    ENV["CLOUD_API_KEY"],
  api_secret: ENV["CLOUD_API_SECRET"],
)

Shrine.storages = {
  cache: Shrine::Storage::Cloudinary.new(prefix: "cache"),
  store: Shrine::Storage::Cloudinary.new(prefix: "rails_uploads"),
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :validation_helpers
Shrine.plugin :validation
Shrine.plugin :determine_mime_type