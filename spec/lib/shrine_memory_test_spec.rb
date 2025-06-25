# spec/lib/shrine_memory_test_spec.rb

require "rails_helper"
require "shrine"
require "shrine/storage/memory"

RSpec.describe "Shrine memory storage test" do
  it "loads Shrine memory storage" do
    Shrine.storages = {
      cache: Shrine::Storage::Memory.new,
      store: Shrine::Storage::Memory.new
    }

    expect(Shrine.storages[:cache]).to be_a(Shrine::Storage::Memory)
    expect(Shrine.storages[:store]).to be_a(Shrine::Storage::Memory)
  end
end
