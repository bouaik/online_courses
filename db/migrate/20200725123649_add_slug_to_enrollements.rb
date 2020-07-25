class AddSlugToEnrollements < ActiveRecord::Migration[6.0]
  def change
    add_column :enrollements, :slug, :string
    add_index :enrollements, :slug, unique: true
  end
end
