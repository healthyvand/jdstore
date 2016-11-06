class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  # before_action :admin_required, only: [:order_to_cancell]

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.total_price

    if @order.save

      current_cart.cart_items.each do |cart_item|
        product_list = ProductList.new
        product_list.order = @order
        product_list.product_name = cart_item.product.title
        product_list.product_price = cart_item.product.price
        product_list.quantity = cart_item.quantity
        product_list.save
      end

      redirect_to order_path(@order.token)
    else
      render 'carts/checkout'
    end
  end

  def show
    @order = Order.find_by_token(params[:id])
    @product_lists = @order.product_lists
  end

  # 支付宝付款
  def pay_with_alipay
    @order = Order.find_by_token(params[:id])
    if @order.is_paid == true
      redirect_to payfailed_order_path,alert: "付款失败，该订单已被支付"
    else
      @order.payment_method = 'alipay'
      @order.is_paid = true

      # 发邮件
      OrderMailer.notify_order_placed(@order).deliver
      # 状态转换
      @order.make_payment!


      @order.save
      redirect_to paysuccess_order_path,notice: "付款成功"
    end
  end

  # 微信付款
  def pay_with_wechat
    @order = Order.find_by_token(params[:id])
    if @order.is_paid == true
      redirect_to payfailed_order_path,alert: "付款失败，该订单已被支付"
    else
      @order = Order.find_by_token(params[:id])
      @order.payment_method = 'wechat'
      @order.is_paid = true 

      # 发订单确认邮件
      OrderMailer.notify_order_placed(@order).deliver
      # 状态转换
      @order.make_payment!

      @order.save 
      redirect_to paysuccess_order_path,notice: "付款成功"
    end
  end

  # 支付成功
  def paysuccess
    @order = Order.find_by_token(params[:id])
    # flash[:notice] = "付款成功"
    render 'orders/paysuccess'
  end

  # 支付失败
  def payfailed
    @order = Order.find_by_token(params[:id])
    # flash[:notice] = "付款失败，该订单已被支付"
    render 'orders/payfailed'
  end

  def coupon
    @order = Order.find_by_token(params[:id])
    # 优惠码
    code = coupon_params[:coupon_code]
    @order.coupon_code = code
    puts '~~'
    puts code
    puts '~~'
    case code
    when 'fbd9'

      @order.total = @order.total * 0.9
      @order.save
    when 'fbd8'
      @order.total = @order.total * 0.8
      @order.save
    when 'fbd7'
      @order.total = @order.total * 0.7
      @order.save
    when 'fbd6'
      @order.total = @order.total * 0.6
      @order.save
    else
      return redirect_to :back , notice: "该优惠码不存在"
    end

    return redirect_to :back , notice: "优惠码使用成功"
    
  end




  private

  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :shipping_name, :shipping_address,:coupon_code)
  end

  def coupon_params
    params.require(:order).permit(:coupon_code)
    
  end



end
