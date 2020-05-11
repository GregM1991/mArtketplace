class AddPriceToListing < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :price, :int
  end
end
