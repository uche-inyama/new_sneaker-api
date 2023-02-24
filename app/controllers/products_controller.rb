class ProductsController < ApplicationController
	def index
		@product = Product.all
	end

	def product_params
		params.require(:product).permit(:name, :product_price, :product_discount, :marketing_statement)
	end

	private :product_params
end