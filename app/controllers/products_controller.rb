class ProductsController < ApplicationController
  layout "naked"
  
  def index
    @products = Product.find(:all)
  end
  
  def show
    @product = Product.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @product }
    end
  end
end
