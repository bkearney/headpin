class ProductsController < ApplicationController
  layout "naked"
  
  def index
    respond_to do |format|
      format.html
      format.json  {
        @products = Product.find(:all)
        data = GridData.new() 
        data.set_records(@products)        
        render :json => data 
      }      
    end    
  end
  
  def show
    @product = Product.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @product }
    end
  end
  
  def cert
    product = Product.find(params[:id])      
    render :text => product.cert.certificateString 
  end
end
