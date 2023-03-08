class SamplesController < ApplicationController
  before_action :set_product

  def index
    @product_samples = @product.samples
  end

  def new
    @sample = @product.samples.build
  end

  def create
    @sample = @product.samples.build(sample_params)
    respond_to do |format|
      if @sample.save
        format.html
        format.json { render json: @sample, status: :ok }
      else 
        format.json { render json: :unprocessable_entity }
      end
    end
  end

  def sample_params
    params.require(:sample).permit(:image, :product_id)
  end

  def set_product
    @product = Product.find params[:product_id]
  end

  private :sample_params, :set_product
end