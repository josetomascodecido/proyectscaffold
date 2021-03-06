class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @store = Store.find(params[:store_id])
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @store = Store.find(params[:store_id])
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @store = Store.find(params[:store_id])
    @product.store = @store

    respond_to do |format|
      if @product.save
        format.html { redirect_to store_path(@store), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @store = Store.find(params[:store_id])
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to store_path(@store), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @store = Store.find(params[:store_id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to store_path(@store), notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :image, :price, :store_id, :remote_image_url)
    end
end
