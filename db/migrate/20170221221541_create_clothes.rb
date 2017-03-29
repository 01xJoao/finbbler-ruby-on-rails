class CreateClothes < ActiveRecord::Migration
  def change
    create_table :clothes do |t|
      t.string :clothe_name
      t.integer :price
      t.string :store_name
      t.string :store_link
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
