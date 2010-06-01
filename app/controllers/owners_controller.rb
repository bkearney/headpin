class OwnersController < ApplicationController
  layout "naked"
  
  def index
    @owners = Owner.find(:all)
  end
  
  def show
    @owner = Owner.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @sample }
    end
  end
  
  def new
    @owner = Owner.new()
    @pool = Pool    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @owner }
    end        
  end    
  
  def create
    @owner = Owner.new(params[:owner])
    respond_to do |format|
      if @owner.save
        flash[:notice] = 'Owner was successfully created.'
        format.html { redirect_to(owner_url(:id => @owner.id)) }
        format.xml  { render :xml => @owner, :status => :created}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @owner.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @owner = Owner.find(params[:id])
    @owner.destroy()
    
    respond_to do |format|
      format.html { redirect_to(owner_list_url) }
      format.xml  { head :ok }
    end
  end
end
