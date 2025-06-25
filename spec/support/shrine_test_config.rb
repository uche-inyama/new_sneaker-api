require "shrine/storage/memory"

puts "Shrine test config loaded"

Shrine.storages = {
  cache: Shrine::Storage::Memory.new,
  store: Shrine::Storage::Memory.new,
}
