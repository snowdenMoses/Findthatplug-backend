class CreateProductCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :product_categories do |t|
      t.integer :product_id
      t.integer :category_id
      t.timestamps
    end
  end
end
