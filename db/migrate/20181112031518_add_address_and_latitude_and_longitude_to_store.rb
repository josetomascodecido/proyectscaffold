class AddAddressAndLatitudeAndLongitudeToStore < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :address, :string
    add_column :stores, :latitude, :float
    add_column :stores, :longitude, :float
  end
end
