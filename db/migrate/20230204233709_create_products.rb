class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :string
      t.string :description
      t.string :text
      t.string :price
      t.string :decimal

      t.timestamps
    end
  end
end
