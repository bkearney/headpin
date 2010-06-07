class ConsumersController < ApplicationController
  layout "naked"
  
  def index
    types = Consumertype.find(:all)
    @typeSelect = ""
    types.each() do |type|
      @typeSelect << type.id.to_s
      @typeSelect << ":"
      @typeSelect << type.label
      @typeSelect << ";"
    end
    respond_to do |format|
      format.html
      format.json  {
        @consumers = Consumer.find(:all)
        data = GridData.new() 
        data.set_records(@consumers)        
        render :json => data 
      }      
    end    
  end
  
  
  def update
    id = params[:id]
    oper = params[:oper]
    case oper
      when "edit"
        type = Consumer.find(params[:id])
        type.update_attributes(params)
        type.save
      when "del"
        type = Consumer.find(params[:id])
        type.destroy
      when "add"
        create
    end
    render :nothing => true
  end    
  
  def cert
    cons = Consumer.find(params[:id])      
    render :text => cons.certificateString 
  end  
  
  def facts
        consumer = Consumer.find(params[:id])
        data = GridData.new() 
        data.set_records(consumer.facts.entries)        
        render :json => data     
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
    #attributes = params[:consumer]
    attributes = params
    attributes.delete(:id)
    attributes.delete(:oper)
    attributes.delete(:action)
    attributes.delete(:controller)    
    if attributes["type.id"]
      attributes["type"]= Consumertype.find(attributes["type.id"])
      attributes.delete "type.id"
    end
    @consumer = Consumer.new(attributes)
    # Set up the facts
    @consumer.facts= ConsumerFacts.new()
    facts = []
    if params[:entry]
      params[:entry].each() do |k,v|
        facts << ConsumerFacts::Entry.new(v) if v["key"] != ""
      end 
    end
    @consumer.facts.entry= facts
    @consumer.save
#    respond_to do |format|
#      if @consumer.save
#        flash[:notice] = 'Consumer was successfully created.'
#        format.html { redirect_to(consumer_url(:uuid => @consumer.uuid)) }
#        format.xml  { render :xml => @consumer, :status => :created }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @consumer.errors, :status => :unprocessable_entity }
#      end
#    end
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
