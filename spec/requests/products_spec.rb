require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:valid_attributes) do
    {
      name: "Test Product",
      product_price: 99.99,
      product_discount: 10.0,
      marketing_statement: "The best product ever"
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      product_price: nil
    }
  end

  let!(:product) { Product.create!(valid_attributes) }

  describe "GET #products.json" do
    it "returns a success response with JSON" do
      get products_path, as: :json

      expect(response).to have_http_status(:ok)
      parsed = JSON.parse(response.body)
      expect(parsed).to be_an(Array)
      expect(parsed.first["name"]).to eq("Test Product")
    end
  end

  describe "GET #show" do
    it "returns the product as JSON" do
      get product_path(product), as: :json

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["name"]).to eq("Test Product")
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new product" do
        expect {
          post products_path, params: { product: valid_attributes }, as: :json
      }.to change(Product, :count).by(1)

      expect(response).to have_http_status(:ok)
      parsed = JSON.parse(response.body)
      expect(parsed["name"]).to eq("Test Product")
      end
    end

    context "with invalid params" do
      it "does not create a new Product and returns unprocessable_entity" do
        expect {
          post products_path, params: { product: invalid_attributes }, as: :json
      }.not_to change(Product, :count)
      
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to include("name", "product_price")
      end
    end
  end

  describe "PATCH Update" do
    it "updates the product and returns JSON" do
      put product_path(product), params: {product: { name: "Updated Name"}}, as: :json
      expect(response).to have_http_status(:ok)
      expect(product.reload.name).to eq("Updated Name")
    end
  end

  describe "Delete" do
    it "deletes the product and returns a JSON" do
      expect {
        delete product_path(product)
    }.to change(Product, :count).by(-1)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(products_path)
      follow_redirect!
    end
  end
end
