class Api::ApexdatasController < ApplicationController
    def index
        @apexdatas = ApexData.order('created_at DESC')
    end
    
    def create
        @apexdata = ApexData.new(apexdata_params)
        if @apexdata.save
            render :show, status: :created
        else
            render json: @apexdata.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @apexdata = ApexData.find(params[:id])
        @apexdata.destroy
    end

    def show
        @apexdata = ApexData.find(params[:id])
    end

    private
        def apexdata_params
            params.permit(:damage, :killassist, :teamkill, :ranking)
        end
end
