class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :community
  belongs_to :post_board
end