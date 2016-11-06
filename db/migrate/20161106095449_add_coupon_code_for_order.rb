class AddCouponCodeForOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :coupon_code, :string
  end
end
