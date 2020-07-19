class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
      @courses = Course.all.limit(3)
      @recent_courses = Course.all.limit(3).order(created_at: :desc)
  end
end
