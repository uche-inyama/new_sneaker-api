class ProductsController < ApplicationController
	def index
		@products = Product.all
		respond_to do |format|
			format.html
			format.json { render json: @product, status: :ok }
		end
	end

	def new
		@product = Product.new
	end

	def product_params
		params.require(:product).permit(:name, :product_price, :product_discount, :marketing_statement)
	end

	private :product_params
end