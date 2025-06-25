require "rails_helper"

RSpec.describe "Samples", type: :request do
  let(:product) { create(:product) }
  let(:sample) { create(:sample) }
  let(:valid_image_data) do {
      id: "some-id",
      storage: "store",
      metadata: {
        filename: "new_image.jpg",
        size: 123456,
        mime_type: "image/jpg"
      }
    }.to_json
  end

  describe "Post #create" do
    it "creates a new sample and redirects" do
      file = Rack::Test::UploadedFile.new(
        Rails.root.join("spec/fixtures/files/nike-mail.png"), 
        "image/png"
      )

      post product_samples_path(product), params: {
        sample: {
          image: file,
          name: "Test Sample"
        }
      }
      expect(response).to redirect_to(product_samples_path(product))
      expect(product.samples.last.image).to be_present
    end
  end

  describe "patch #update" do
    it "it updates a sample object and returns a JSON" do
      put product_sample_path(product, sample), params: {sample: {image: valid_image_data}}, as: :json
      
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(product_samples_path(product))
    end
  end
end
