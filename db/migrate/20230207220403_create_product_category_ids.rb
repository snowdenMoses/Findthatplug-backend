class CreateProductCategoryIds < ActiveRecord::Migration[7.0]
  def change
    create_table :product_category_ids do |t|
      t.references :category, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
