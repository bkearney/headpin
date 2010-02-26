class PoolsController < ApplicationController
    layout "headpin"

    def index
        @pools = Pool.find(:all)
    end

    def show
        @pool = Pool.find(params[:id])

        respond_to do |format|
            format.html
            format.xml  { render :xml => @pool }
        end
    end
end