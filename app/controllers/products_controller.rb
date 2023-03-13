class ProductsController < ApplicationController
	before_action :current_user
	before_action :get_product, only: [:show]

	def index
		@products = Product.all
		# render json: @products, status: :ok
		respond_to do |format|
			format.json { render json: @products, status: :ok }
			format.html
		end
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
		respond_to do |format|
			if @product.save
				format.html
				format.json { render json: @product, status: :ok }
			else
				format.html {render :new }
				format.json { render json: :unprocessable_entity }
			end
		end
	end

	def show
		render json: @product
	end

	def product_params
		params.require(:product).permit(:name, :product_price, :product_discount, :marketing_statement)
	end

	def get_product
		@product = Product.find(params[:id])
	end

	private :product_params, :get_product
end