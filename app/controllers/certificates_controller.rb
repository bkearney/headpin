class CertificatesController < ApplicationController
    layout "headpin"
    
    def index
        @certificate = Certificate.find(:first)
        respond_to do |format|
          format.html
          format.xml  { render :xml => @certificate }
        end        
    end
    
    def edit
        @certificate = Certificate.find(:first)
        respond_to do |format|
          format.html
          format.xml  { render :xml => @certificate }
        end        
    end    
    
    def create
        @certificate = Certificate.new()
        @certificate.content = params[:certificate][:content]

        respond_to do |format|
          if @certificate.save
            flash[:notice] = 'Certificate was successfully created.'
            format.html { redirect_to(certificates_url) }
            format.xml  { render :xml => @certificate, :status => :created, :location => @certificate }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @certificate.errors, :status => :unprocessable_entity }
          end
        end
    end        
end
