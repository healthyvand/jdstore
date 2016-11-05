# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  quantity    :integer
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string
#  is_hidden   :boolean          default(FALSE)
#  feet        :string
#  attachpdf   :string
#
# Indexes
#
#  index_products_on_feet  (feet)
#

class Product < ApplicationRecord
    
    mount_uploader :image,  ImageUploader
    # 添加上传pdf设置
    mount_uploader :attachpdf, AttachpdfUploader
    
    validates :title,:quantity,:price,presence: true
end
