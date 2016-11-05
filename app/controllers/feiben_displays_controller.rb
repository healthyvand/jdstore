class FeibenDisplaysController < ApplicationController

  layout "show_display"


  def index
    # if current_user and current_user.admin?
    #   redirect_to '/admin/products'
    # end
    @products = Product.all
  end
  

  def standard_size10
    @products = Product.all   
  end

  def standard_size20
    @products = Product.all   
  end

  def customization
    @products = Product.all   
  end


end
