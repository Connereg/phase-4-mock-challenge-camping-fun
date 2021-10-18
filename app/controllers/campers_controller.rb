class CampersController < ApplicationController

    def index
        render json: Camper.all
    end

    def show
        begin
            camper = Camper.find(params[:id])      
           rescue ActiveRecord::RecordNotFound
                render json: {error: "Camper not found"}
           else 
                render json: camper, serializer: CamperWithActivitiesSerializer
           end
    end

    def create
        camper = Camper.new(camper_params)
        begin
            camper.save
        rescue ActiveRecord::ValidationError
            render json: {error: "validation errors"}, status: :unprocessable_entity
        else 
            render json: camper, status: :created
        end
    end



    private

    def camper_params
        params.permit(:name, :age)
    end
end
