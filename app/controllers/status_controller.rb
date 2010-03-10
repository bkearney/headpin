class StatusController < ApplicationController
  layout "headpin"
  
  # Need to Restify this
  def ping
    @status = Status.find(:first)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @status }
    end        
  end  
end