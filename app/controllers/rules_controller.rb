class RulesController < ApplicationController
    layout "headpin"
       
    def index
        @rules = Rules.find(:first)
        respond_to do |format|
          format.html
          format.xml  { render :xml => @rules }
        end        
    end
    
    # FIXME When we get indexes, this should break out into
    # both a certificate/new and certificate/%{id} show    
    def edit
        @rules = Rules.find(:first)
        respond_to do |format|
          format.html
          format.xml  { render :xml => @rules }
        end        
    end    
    
    def create
        @rules = Rules.new()
        @rules.content = params[:rules][:content]

        respond_to do |format|
          if @rules.save
            flash[:notice] = 'Rules were successfully created.'
            format.html { redirect_to(rules_url) }
            format.xml  { render :xml => @rules, :status => :created, :location => @rules }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @rules.errors, :status => :unprocessable_entity }
          end
        end
    end        
end
