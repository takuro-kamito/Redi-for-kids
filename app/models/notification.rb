class Notification < ApplicationRecord
    default_scope -> { order(created_at: :desc) }

  belongs_to :room, optional: true
  belongs_to :message, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  
  def self.unread
     where(read: false)
  end
  
  def read
    checked.present?
  end

end
