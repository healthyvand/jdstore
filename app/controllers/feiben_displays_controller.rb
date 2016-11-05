class FeibenDisplaysController < ApplicationController

  layout "show_display"


  def index
    # if current_user and current_user.admin?
    #   redirect_to '/admin/products'
    # end
    @products = Product.all
  end
  

  def standard_size10
    @products = Product.where(feet: "10'x10'")   
  end

  def standard_size20
    @products = Product.where(feet: "20'x20'")
  end

  def customization
    @products = Product.where(feet: "customization")  
  end

  # 物品展示
  def show
    @product = Product.find(params[:id])
  end



end
