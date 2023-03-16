class SamplesController < ApplicationController
  before_action :set_product
  before_action :set_sample, only: [:show, :edit, :update, :destroy]

  def index
    @samples = @product.samples
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

  def show
  end

  def edit
  end

  def update
    if @sample.update(sample_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @sample.destroy
    redirect_to edit_product_sample_path
  end

  def sample_params
    params.require(:sample).permit(:image, :product_id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_sample
    @sample = Sample.find(params[:id])
  end

  private :sample_params, :set_product
end