FactoryBot.define do
  factory :sample do
    association :product 

    image_data do
      {
        "id" => "some-id",
        "storage" => "store",
        "metadata" => {
          "filename" => "test.jpg",
          "size" => 12345,
          "mime_type" => "image/jpeg"
        }
      }.to_json
    end
  end
end