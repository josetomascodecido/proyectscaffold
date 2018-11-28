
class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

# frozen_string_literal: true
  def empty_cart
    @store = Store.find(params[:store_id])
    @set_orders = Order.where(user: current_user, store_id: @store.id)
    @set_orders.destroy_all
    redirect_to store_orders_path(@store),  notice: 'Se ha vaciado su bandeja'
  end

  def create

    @store = Store.find(params[:store_id])
    @product = Product.find(params[:product_id])
    @cart = current_user.cart

    if @cart.pluck(:product_id).include?(params[:product_id].to_i)
      product = current_user.orders.find_by(product_id: params[:product_id])
      product.quantity += 1
      @order = product
    else
      product = current_user.orders.build(product_id: @product.id, price: @product.price, payed: false)
      @order = Order.new(product_id: @product.id, user: current_user, store_id: @store.id, price: @product.price, quantity: 1)
    end

    if @order.save

      redirect_to @store, notice: 'Tu producto fue agregado al carro!'
    else
      redirect_to @store, alert: 'Intenta nuevamente CTM!'
    end
  end

  def index
    @store = Store.find(params[:store_id])
     @orders = Order.where(store_id: @store.id, user: current_user, payed: false)
    @products = @orders.map do |order|
      @products = Product.find(order.product.id)
    end
    @total = 0
    @price_quantity = @orders.pluck(:price, :quantity)
    @price_quantity.each do |price|
      @total += (price[0]*price[1]).to_i
    end
  end

  def destroy

    @order = current_user.orders.find(params[:id])
        respond_to do |format|
        if @order.destroy
          format.html { redirect_to store_orders_path(params[:store_id]), notice: 'eliminado exitosamente'}
        else
          format.html { redirect_to store_orders_path(params[:store_id]), notice: 'no pudimos eliminar tu producto'}

      end
    end
  # #   if @order.quantity == 1
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
