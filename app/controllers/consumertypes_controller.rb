require "grid_data"
class ConsumertypesController < ApplicationController
  layout "naked"
  
  def index
    respond_to do |format|
      format.html
      format.json  {
        @types = Consumertype.find(:all)
        data = GridData.new() 
        data.set_records(@types)        
        render :json => data 
      }      
    end    
  end
  
  
  def update
    id = params[:id]
    oper = params[:oper]
    case oper
      when "edit"
        type = Consumertype.find(params[:id])
        type.update_attributes(params)
        type.save
      when "del"
        type = Consumertype.find(params[:id])
        type.destroy
      when "add"
        type = Consumertype.new()
        type.update_attributes(params)
        type.save()
    end
    render :nothing => true
  end    
  
end
