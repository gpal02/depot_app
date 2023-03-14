class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart
  
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true) 
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title).page(params[:page])
    end
  end

  def questions
    
  end

  def news
    
  end

  def contact
    
  end
end
