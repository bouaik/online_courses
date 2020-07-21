class ApplicationController < ActionController::Base
    include PublicActivity::StoreController 

    before_action :authenticate_user!
    before_action :set_global_variables, if: :user_signed_in?


    def set_global_variables
        @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search) # navbar_search
    end

    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized # pundit
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to(request.referrer || root_path)
    end
end
