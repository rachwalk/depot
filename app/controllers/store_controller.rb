class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order(:title)
    if session[:counter].nil?
      session[:counter] = 0
    end
    @counter = session[:counter]
    session[:counter] = session[:counter]+1
  end
end
