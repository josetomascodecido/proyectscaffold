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
      product = current_user.orders.find_by(product_id: params[:product_id], payed: 0)
      product.quantity += 1
      @order = product
    else
      product = current_user.orders.build(product_id: @product.id, price: @product.price, payed: 'cart')
      @order = Order.new(product_id: @product.id, user: current_user, store_id: @store.id, price: @product.price, quantity: 1)
    end
    @orders = Order.where(store_id: @store.id, user: current_user, payed: 'cart')
    respond_to do |format|
      if @order.save
        @r =  'Tu producto fue agregado al carro!'
        format.js #,  {notice: 'Tu producto fue agregado al carro!'}
      else
        @r = 'Intenta nuevamente CTM!'
        format.js #,  {alert: 'Intenta nuevamente CTM!'}
      end
    end
  end

  def index
    @store = Store.find(params[:store_id])
    if current_user.local_admin?
      @completeds =  Order.where(store_id: @store.id, payed: 'completed')
      @orders = Order.where("payed= ? and store_id = ?", 1, @store.id)
    else
      @completeds =  Order.where(store_id: @store.id, user: current_user, payed: 'completed')
      @inprocess = Order.where(store_id: @store.id, user: current_user, payed: 'payed')
      @orders = Order.where(store_id: @store.id, user: current_user, payed: 'cart')
    end
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
          format.js
        else
          format.html { redirect_to store_orders_path(params[:store_id]), notice: 'no pudimos eliminar tu producto'}
          format.js
      end
    end
  end
  def payed_orders
    @orders = current_user.cart.update_all("payed = 1")
    redirect_to store_orders_path(params[:store_id])
  end

  def confirm_order
    @order = Order.find(params[:id])
    @order.payed = 'completed'
    @order.save
    redirect_to store_orders_path(params[:store_id])
  end

  def delivered_order
    @order = Order.find(params[:id])
    @order.payed = 'delivered'
    @order.save
    redirect_to store_orders_path(params[:store_id])
  end
  def historial
    @store = Store.find(params[:store_id])
    @orders=  Order.where(store_id: @store.id, payed: 'delivered')
  end

  private



  def set_cart
    @setcart = current_user.cart
  end

end
