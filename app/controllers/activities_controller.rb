class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index 
        render json: Activity.all
    end

    def destroy 
       begin
        activity = Activity.find(params[:id])      
       rescue ActiveRecord::RecordNotFound
        render json: {error: "Activity not found"}
       else 
            activity.destroy
            render json: activity, status: :no_content
       end 
    end
end
