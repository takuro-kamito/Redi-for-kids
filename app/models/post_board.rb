class PostBoard < ApplicationRecord
  belongs_to :community
  belongs_to :user
  validates :body, presence: true

  POST_BOARD = "Post_board"

  def self.search_for(content, method)
  case method
  when "body"
    joins(:user).where('body LIKE ?', '%' + content.to_s)
  else
    joins(:user).where('body LIKE ?', '%' + (content || '').to_s + '%')
  end
  end
end
