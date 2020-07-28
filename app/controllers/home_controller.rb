class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @courses = Course.all.limit(3)
    @latest_courses = Course.latest_courses
    @latest_good_review = Enrollement.reviewd.latest_good_review
    @top_rated_courses = Course.top_rated_courses
    @popular_courses = Course.popular_courses
    @purchased_courses = Course.joins(:enrollements).where(enrollements: {user: current_user}).order(created_at: :desc).limit(3)

  end

  def activity
    if current_user.has_role?(:admin)
      @activities = PublicActivity::Activity.all.order(created_at: :desc)
    else
      redirect_to root_path, alert: 'Go AWAAAY !!!.'
    end
  end

  def analytics
    if current_user.has_role?(:admin)
      # @users = User.all
      # @enrollement = Enrollement.all
      # @courses = Course.all
    else
      redirect_to root_path, alert: 'Go AWAAAY !!!.'
    end
  end
end
