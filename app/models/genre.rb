class Genre < ApplicationRecord
    has_many :communities
    validates :name, presence: true
end
