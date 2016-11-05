class AddAttachpdfToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :attachpdf, :string
  end
end
