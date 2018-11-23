
class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

# frozen_string_literal: true
  def empty_cart
    @setcart.destroy_all
    redirect_to store_product_orders_path, notice: 'Se ha vaciado su bandeja'
  end

  def create
    @store = Store.find(store_id: params[:store_id])
    @product = Product.find(product_id: params[:product_id])
    @cart = current_user.cart

    if @cart.pluck(:product_id).include?(params[:product_id].to_i)
      product = current_user.orders.find_by(product_id: params[:product_id])
      product.quantity += 1
      @order = product
    else
      product = current_user.orders.build(product_id: @product.id, price: @product.price, payed: false)
      @order = Order.new(product_id: @product.id, user: current_user, price: @product.price, quantity: 1)
    end

    if @order.save

      redirect_to @store, notice: 'Tu producto fue agregado al carro!'
    else
      redirect_to @store, alert: 'Intenta nuevamente CTM!'
    end
  end

  def index
    @store = Store.find(params[:store_id])
    @orders = current_user.cart
    @total = 0
    @price_quantity = current_user.orders.pluck(:price, :quantity)
    @price_quantity.each do |price|
      @total += (price[0]*price[1]).to_i
    end
  end

  def destroy

    @orders = current_user.orders.where(product_id: params[:product_id])

    @orders.each do |order|
      respond_to do |format|
        if order.destroy
          format.html { redirect_to store_product_orders_url, notice: 'eliminado exitosamente'}
        else
          format.html { redirect_to store_product_orders_url, notice: 'no pudimos eliminar tu producto'}
        end
      end
    end
  #   if @order.quantity == 1
  #     if @order.destroy
  #       redirect_to store_product_orders_path(:store_id, :product_id), notice: 'Carro actualizado'
  #     else
  #       redirect_to store_product_orders_path(:store_id, :product_id), alert: 'Error al actualizar el carro'
  #     end
  #   elsif @order.quantity > 1
  #     @order.quantity -= 1
  #     if @order.save
  #       redirect_to store_product_orders_path(:store_id, :product_id), notice: 'Carro actualizado'
  #     else
  #       redirect_to store_product_orders_path(:store_id, :product_id), alert: 'Error al actualizar el carro'
  #     end
  #   end
  end
  private

  def set_cart
    @setcart = current_user.cart
  end
end
