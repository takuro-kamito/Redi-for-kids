class Community < ApplicationRecord
  has_many :post_boards, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :genre

   validates :name, :explanation, presence: true

  def comment_count #post_boardにコメントして数をカウント
    post_boards.count
  end

   def favorited_by?(user) #favorited_by?(user)`メソッドは、引数として指定されたユーザーが、`favorites`という関連付けられたオブジェクトのレコードにおいて、`user_id`と一致する行が存在するかどうかを判定
    favorites.where(user_id: user.id).exists? #`favorites`に対して`where(user_id: user.id)`という条件を指定し、その結果が存在するかどうかを判定。存在する場合は`true`を返し、存在しない場合は`false`を返す。
   end

  def self.search_for(content, method) #serch_forメソッドに条件を指定
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
