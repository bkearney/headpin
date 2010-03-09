class ConsumersController < ApplicationController
    layout "headpin"
    
    def index
        @consumers = Consumer.find(:all)
    end
    
  def show
    @consumer = Consumer.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @consumer }
    end
  end
  
    def new
        @consumer = Owner.new()    
        respond_to do |format|
          format.html
          format.xml  { render :xml => @consumer }
        end        
    end    
    
    def create
        @consumer = Owner.new(params[:consumer])
        respond_to do |format|
          if @consumer.save
            flash[:notice] = 'Consumer was successfully created.'
            format.html { redirect_to(owner_url(:id => @consumer.id)) }
            format.xml  { render :xml => @consumer, :status => :created }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @consumer.errors, :status => :unprocessable_entity }
          end
        end
    end
    
    def destroy
        @consumer = Owner.find(params[:id])
        @consumer.destroy()
        
        respond_to do |format|
          format.html { redirect_to(consumer_list_url) }
          format.xml  { head :ok }
        end
    end
end
