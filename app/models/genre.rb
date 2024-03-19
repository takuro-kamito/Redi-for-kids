class Genre < ApplicationRecord
  has_many :community

  validates :name, presence: true
end
