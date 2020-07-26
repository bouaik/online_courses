class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @courses = Course.all.limit(3)
    @recent_courses = Course.all.limit(3).order(created_at: :desc)
    @latest_good_review = Enrollement.reviewd.order(rating: :desc , created_at: :desc).limit(3)

    @top_rated_courses = Course.order(average_rating: :desc, created_at: :desc).limit(3)
    @popular_courses = Course.order(enrollements: :desc, created_at: :desc).limit(3)
    @purchased_courses = Course.joins(:enrollements).where(enrollements: {user: current_user}).order(created_at: :desc).limit(3)
  end
  def activity
    @activities = PublicActivity::Activity.all
  end
end
