class OrdersController < ApplicationController
  def create
    @store = Store.find(params[:store_id])
    @product = Product.find(params[:product_id])
    @order = Order.create(store: @store, product_id: @product.id, user: current_user)
  end
  def index
    @product = Product.find(params[:product_id])
    @orders = Order.all
  end
end
