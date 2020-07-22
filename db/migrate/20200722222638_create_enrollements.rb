class CreateEnrollements < ActiveRecord::Migration[6.0]
  def change
    create_table :enrollements do |t|
      t.integer :rating
      t.text :review
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
