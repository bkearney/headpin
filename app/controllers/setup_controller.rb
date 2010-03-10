class SetupController < ApplicationController
  layout "headpin"
  
  def show
    @setup = Setup.new() 
    @setup.site = CandlepinObject.site
  end  
  
  def update
    @setup = Setup.new(params["setup"])
    CandlepinObject.site= @setup.site
    respond_to do |format|
      format.html { redirect_to(setup_url) }
    end
  end         
end