class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @courses = Course.all.limit(3)
    @recent_courses = Course.all.limit(3).order(created_at: :desc)
    @enrollements = Enrollement.reviewd.order(rating: :desc , created_at: :desc).limit(3)
  end

  def activity
    @activities = PublicActivity::Activity.all
  end
end
