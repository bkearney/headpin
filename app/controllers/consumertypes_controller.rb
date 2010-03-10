class ConsumertypesController < ApplicationController
  layout "headpin"
  
  def index
    @types = Consumertype.find(:all)
  end
  
  def show
    @type = Consumertype.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @type }
    end
  end
  
  def edit
    @type = Consumertype.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @type }
    end
  end  
  
  def update
    @type = Consumertype.find(params[:id])
    @type.label= params[:consumertype][:label]
    respond_to do |format|
      if @type.save
        flash[:notice] = 'ConsumerType was successfully created.'
        format.html { redirect_to(consumertype_url(@type)) }
        format.xml  { render :xml => @type, :status => :created}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @type.errors, :status => :unprocessable_entity }
      end
    end
  end    
  
  def new
    @type = Consumertype.new()  
    respond_to do |format|
      format.html
      format.xml  { render :xml => @type }
    end        
  end    
  
  def create
    @type = Consumertype.new(params[:consumertype])
    respond_to do |format|
      if @type.save
        flash[:notice] = 'ConsumerType was successfully created.'
        format.html { redirect_to(consumertype_url(@type)) }
        format.xml  { render :xml => @type, :status => :created}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @type.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @type = Consumertype.find(params[:id])
    @type.destroy()
    
    respond_to do |format|
      format.html { redirect_to(consumertypes_url) }
      format.xml  { head :ok }
    end
  end
end
