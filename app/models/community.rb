class Community < ApplicationRecord
  has_many :post_boards, dependent: :destroy
end
