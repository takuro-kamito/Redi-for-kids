class Post < ApplicationRecord
 belongs_to :community
 belongs_to :user
has_many :favorites
end 