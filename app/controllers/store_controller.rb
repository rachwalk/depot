class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    if session[:counter].nil?
      session[:counter] = 0
    end
    @counter = session[:counter]
    session[:counter] = session[:counter]+1
  end
end
