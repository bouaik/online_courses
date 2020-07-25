class Course < ApplicationRecord
    validates :title, :short_description, :language, :price, :level, presence: true
    validates :description, presence: true, length: { minimum: 5 }

    belongs_to :user
    has_many :lessons, dependent: :destroy
    has_many :enrollements

    has_rich_text :description

    extend FriendlyId
    friendly_id :title, use: :slugged

    LANGUAGES = [:"English", :"Arabic", :"chinese", :"spanish"]
    def self.languages 
        LANGUAGES.map { |language| [language, language]}
    end

    LEVELS = [:"Beginner", :"Intermidiate", :"Advanced"]
    def self.levels 
        LEVELS.map { |language| [language, language]}
    end

    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user }
    
    def to_s
        title
    end

    def bought(user)
        self.enrollements.where(user_id: [user.id], course_id: [self.id]).empty?
    end


    def update_rating
        if enrollements.any? && enrollements.where.not(rating: nil).any?
            update_column :average_rating, (enrollements.average(:rating).round(2).to_f)
        else
            update_column :average_rating, (0)
        end
    end
end
