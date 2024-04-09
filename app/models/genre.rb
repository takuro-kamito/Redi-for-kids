class Genre < ApplicationRecord
    has_many :communites
    validates :name, presence: true
end
