class OrdersController < ApplicationController

  def create
    @store = Store.find(params[:store_id])
    @product = Product.find(params[:product_id])
    @order = Order.new(product_id: @product.id, user: current_user, price: @product.price)
    if @order.save
      redirect_to store_product_orders_path(@store, @product), notice: 'Tu producto fue agregado al carro!'
    else
      redirect_to store_path(@store), alert: 'Intenta nuevamente CTM!'
    end
  end

  def index
    @orders = current_user.cart
    @total = @orders.pluck(:price).sum
  end
end
