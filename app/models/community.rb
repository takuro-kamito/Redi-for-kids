class Community < ApplicationRecord
  has_many :post_boards, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user,optional: true
  belongs_to :genre

   validates :name, :explanation, presence: true

  def comment_count
    post_boards.count
  end

   def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
   end

  def self.search_for(content, method)
    if method == 'perfect'
      Community.where(name: content)
    elsif method == 'forward'
      Community.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Community.where('name LIKE ?', '%' + content)
    else
      Community.where('name LIKE ?', '%' + content + '%')
    end
  end
end
