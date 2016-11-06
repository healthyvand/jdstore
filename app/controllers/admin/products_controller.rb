class Admin::ProductsController < ApplicationController
  before_action :authenticate_user! , only: [:index]
  before_action :admin_required

  layout "admin"

  def index
    @products = Product.all
  end



  def create
    @product = Product.new(product_params)
    if @product.save

      # 传多张图
      if params[:photos] != nil
        params[:photos]['avatar'].each do |a|
          @photo = @product.photos.create(:avatar => a)
        end
      end

      redirect_to admin_products_path, notice: "新建成功"
    else
      render :new
    end
  end

  def new
    @product = Product.new
    #for multi-pics
    @photo = @product.photos.build
  end

  def edit
    @product = Product.find(params[:id])
  end

  def show
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    # 上传多图的修改更新
    if params[:photos] != nil
      @product.photos.destroy_all #need to destroy old pics first

      params[:photos]['avatar'].each do |a|
        @picture = @product.photos.create(:avatar => a)
      end

      @product.update(product_params)
      redirect_to admin_products_path, notice: "更新成功"

    
    elsif @product.update(product_params)
      redirect_to admin_products_path,  notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])

    @product.destroy
    redirect_to admin_products_path

  end

  # 可以改变状态按钮
  def publish
    @product = Product.find(params[:id])
    @product.is_hidden = false
    @product.save

    redirect_to :back
  end

  def private
    @product = Product.find(params[:id])
    @product.is_hidden = true
    @product.save

    redirect_to :back    
  end

  # def order
  #   @product = Product.find(params[:id])
  #   pid = @product.id
  #   uid = current_user.id
  #   puts  pid
  #   puts  uid

  #   User.create([id: pid, user_id: uid])
  # end



  private

  def product_params
    params.require(:product).permit(:title, :description, :image,:quantity, :price, :feet,:attachpdf,:photos)
  end

  def admin_required
    if !current_user.admin?
        redirect_to '/'
    end
  end

end
