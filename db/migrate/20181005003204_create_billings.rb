class CreateBillings < ActiveRecord::Migration[5.2]
  def change
    create_table :billings do |t|
      t.references :order, foreign_key: true
      t.string :code
      t.string :payment_method
      t.decimal :amount
      t.string :currency

      t.timestamps
    end
  end
end
