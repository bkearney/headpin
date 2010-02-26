class OwnersController < ApplicationController
    layout "headpin"
    
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
          format.xml  { render :xml => @certificate }
        end        
    end    
    
    def create
        @owner = Owner.new(params[:owner])

        respond_to do |format|
          if @owner.save
            flash[:notice] = 'Owner was successfully created.'
            format.html { redirect_to(owner_url(:id => @owner.id)) }
            format.xml  { render :xml => @owner, :status => :created, :location => @certificate }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @owner.errors, :status => :unprocessable_entity }
          end
        end
    end          
end
