
class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

# frozen_string_literal: true

  def create
    @store = Store.find(params[:store_id])
    @product = Product.find(params[:product_id])
    @cart = current_user.cart

    if @cart.pluck(:product_id).include?(params[:product_id].to_i)
      product = current_user.orders.find_by(product_id: params[:product_id])
      product.quantity ? product.quantity += 1 : product.quantity = 1
    else
      product = current_user.orders.build(product_id: @product.id, price: @product.price, payed: false)
      # @order = Order.new(product_id: @product.id, user: current_user, price: @product.price)
    end
    if product.save
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
