class AddUserToCourses < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :user, foreign_key: true
  end
end
