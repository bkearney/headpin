require "models/constants.rb"
class SetupController < ApplicationController
  layout "naked"
  
  def show
    @setup = Setup.new() 
    @setup.site = Constants.site
    @setup.user = Constants.user
    @setup.password = Constants.password    
  end  
  
  def update
    @setup = Setup.new(params["setup"])
    Constants.site= @setup.site
    CandlepinObject.site = @setup.site
    Constants.user = @setup.user
    CandlepinObject.user = @setup.user    
    Constants.password = @setup.password    
    CandlepinObject.password = @setup.password        
    render :text => "Success"
  end         
end