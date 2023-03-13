class CartController < ApplicationController
  before_action :set_cart, only: [:add]

  
  def add
    @product = Product.find(params[:product_id])
    @quantity = params[:quantity]
    current_orderable = @cart.orderables.find_by(product_id: @product.id)
    if current_orderable && @quantity > 0
      current_orderable.update(quantity: @quantity)
    # elsif(@quantity <= 0)
    #   current_orderable.destory
    else
      @orderable = @cart.orderables.create(
        product_id: params[:product_id], 
        quantity: @quantity, 
        image: params[:image],
        marketing_statement: params[:marketing_statement],
        product_price: params[:product_price],
        product_discount: params[:product_discount]
      )
      render json: @orderable
    end
  end

  def destroy
    Orderable.find(params[:id]).destroy
    head :no_content
  end

  private

  def set_cart
    @cart ||= Cart.find_by(id: session[:cart_id])
    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  def orderable_params
    params.permit(:product_id, :cart_id, :quantity)
  end
end