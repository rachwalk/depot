class LineItemsController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: %i[ show edit update destroy decrease]

  # GET /line_items or /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1 or /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items or /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)
    @line_item.price = product.price
    session[:counter] = 0
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_index_url}
        format.js {@current_item = @line_item}
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1 or /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: "Line item was successfully updated." }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1 or /line_items/1.json
  def destroy
    cart = @line_item.cart
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to cart, notice: "Removed item from the cart" }
      format.json { head :no_content }
    end
  end

  def decrease
    if(@line_item.quantity <= 1)
      @line_item.destroy
      respond_to do |format|
        format.html {redirect_to store_index_url}
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        if @line_item.update(:quantity => @line_item.quantity-1 )
          format.html { redirect_to store_index_url}
          format.json { render :show, status: :ok, location: @line_item }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end
end
