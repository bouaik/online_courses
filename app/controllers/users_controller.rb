class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update]

    def index
        # @users = User.all.order(created_at: :desc)

        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true)
    end

    def edit
    end

    def update
        if @user.update(users_params)
            redirect_to users_path, notice: "User #{@user.email} was successfully updates"
        else
            render :edit
        end
    end


    private

    def set_user
        @user = User.find(params[:id])
    end

    def users_params
       params.require(:user).permit({role_ids: []})
    end
end