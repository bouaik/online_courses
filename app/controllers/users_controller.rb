class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]

    def index
        # @users = User.all.order(created_at: :desc)

        @q = User.ransack(params[:q])
        # @users = @q.result(distinct: true)
        @pagy, @users = pagy(@q.result(distinct: true), items: 10)


        authorize @users
    end

    def edit
        authorize @user
    end

    def update
        authorize @user
        if @user.update(users_params)
            redirect_to users_path, notice: "User #{@user.email} was successfully updates"
        else
            render :edit
        end
    end

    def show
    end


    private

    def set_user
        @user = User.friendly.find(params[:id])
    end

    def users_params
       params.require(:user).permit({role_ids: []})
    end
end