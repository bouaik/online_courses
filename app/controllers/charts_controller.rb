class ChartsController < ApplicationController
    def users_per_day
      render json: User.group_by_day(:created_at).count
    end

    def enrollements_per_day
        render json: Enrollement.group_by_day(:created_at).count
    end

    def course_popularity
    render json: Enrollement.joins(:course).group(:'courses.title').count
    end

    def money_makers
        render json: Enrollement.joins(:course).group(:'courses.title').sum(:price)
    end

  end