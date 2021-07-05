class AddPayedToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :payed, :integer, default: 0
  end
end
