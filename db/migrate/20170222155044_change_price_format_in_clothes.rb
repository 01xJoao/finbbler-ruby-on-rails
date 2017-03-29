class ChangePriceFormatInClothes < ActiveRecord::Migration
  def change
    change_column :clothes, :price, :float
  end
end
