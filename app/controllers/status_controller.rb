class StatusController < ApplicationController
    layout "headpin"
    
    def ping
        @status = Status.find(:first)
        respond_to do |format|
            format.html
            format.xml  { render :xml => @status }
        end        
    end  
end