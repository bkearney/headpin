class ConsumersController < ApplicationController
  layout "headpin"
  
  def index
    @consumers = Consumer.find(:all)
  end
  
  def show
    @consumer = Consumer.find(params[:uuid])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @consumer }
    end
  end
  
  def new
    @consumer = Consumer.new()  
    @types = {}
    Consumertype.find(:all).each do |type|
      @types[type.label] = type.id
    end
    respond_to do |format|
      format.html
      format.xml  { render :xml => @consumer }
    end        
  end    
  
  def create
    attributes = params[:consumer]
    if attributes["type_id"]
      attributes["type"]= Consumertype.find(attributes["type_id"])
      attributes.delete "type_id"
    end
    @consumer = Consumer.new(attributes)
    respond_to do |format|
      if @consumer.save
        flash[:notice] = 'Consumer was successfully created.'
        format.html { redirect_to(consumer_url(:uuid => @consumer.uuid)) }
        format.xml  { render :xml => @consumer, :status => :created }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @consumer.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @consumer = Consumer.find(params[:id])
    @consumer.destroy()
    
    respond_to do |format|
      format.html { redirect_to(consumer_list_url) }
      format.xml  { head :ok }
    end
  end
end
