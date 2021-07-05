class RemovePayedFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column(:orders, :payed)
    add_column(:orders, :payed, :integer, default: 0)
  end
end
