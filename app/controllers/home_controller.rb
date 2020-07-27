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
    @activities = PublicActivity::Activity.all
  end
end
