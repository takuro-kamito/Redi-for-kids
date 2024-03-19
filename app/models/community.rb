class Community < ApplicationRecord
  has_many :post_boards, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :genre

   def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
   end
  
  def self.search_for(search_form,method)
  where("name LIKE ?", "%#{search_form}%")
  end
end

