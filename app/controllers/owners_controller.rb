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
end
