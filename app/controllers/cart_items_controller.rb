class CartItemsController < ApplicationController

  def item_increase
    @cartItem = CartItem.find(params[:id])
    if !@cartItem.num_increase?
    #   flash[:notice] = "increase"
    # else
      flash[:notice] = "No more available"
    end
    redirect_to carts_path
  end

  def item_decrease
    @cartItem = CartItem.find(params[:id])
    if !@cartItem.num_decrease?
    #   flash[:notice] = "decrease"
    # else
      flash[:notice] = "Quantity always more than 1"
    end
    # @cartItem.num_decrease
    redirect_to carts_path    
  end

  # 闪出指定的item
  def destroy
    # @cart = Cart.find(params[:cart_id])
    @cartItem = CartItem.find(params[:id])
    @cartItem.destroy
    # @product.destroy
    flash[:notice] = "Delete Success"
    redirect_to carts_path
  end
end
