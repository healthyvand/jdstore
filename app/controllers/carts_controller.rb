class CartsController < ApplicationController

  # 清空购物车
  def clear_cart
    # 循环删除
    current_cart.cart_items.each do |item|
      item.destroy
    end
    flash[:notice] = "Cart is empty"
    # 重定向回来
    redirect_to :back
  end

  def checkout
    @order = Order.new
  end



end
