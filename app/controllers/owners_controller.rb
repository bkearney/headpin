class OwnersController < ApplicationController
  layout "naked"
  
  def index
    respond_to do |format|
      format.html
      format.json  {
        @owners = Owner.find(:all)
        data = GridData.new() 
        data.set_records(@owners)        
        render :json => data 
      }      
    end    
  end
  
  def update
    id = params[:id]
    oper = params[:oper]
    case oper
      when "edit"
        type = Owner.find(id)
        type.update_attributes(params)
        type.save
      when "del"
        type = Owner.find(id)
        type.destroy
      when "add"
        type = Owner.new()
        type.update_attributes(params)
        type.save()
    end
    render :nothing => true
  end
  
  def refresh_subscriptions
    id = params[:id]  
    owner = Owner.find(id)
    owner.refresh_subscriptions if owner 
    render :nothing => true
  end
end
