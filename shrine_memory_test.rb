require "shrine"
require "shrine/storage/memory"

storage = Shrine::Storage::Memory.new
puts "Memory storage works!" if storage
