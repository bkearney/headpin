class PoolsController < ApplicationController
  layout "naked"
  
  def index
    respond_to do |format|
      format.html
      format.json  {
        @pools = Pool.find(:all)
        data = GridData.new() 
        data.set_records(@pools)        
        render :json => data 
      }      
    end    
  end
  
  def show
    @pool = Pool.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @pool }
    end
  end
end