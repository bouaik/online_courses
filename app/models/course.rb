class Course < ApplicationRecord
    validates :title, :short_description, :language, :price, :level, presence: true
    validates :description, presence: true, length: { minimum: 5 }

    belongs_to :user

    has_rich_text :description

    extend FriendlyId
    friendly_id :title, use: :slugged
end
