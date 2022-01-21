class Notification < ApplicationRecord
  
  belongs_to :post, optional: true #optional: trueで必要な情報以外にはnilを設定
  belongs_to :comment, optional: true
  belongs_to :room, optional: true
  belongs_to :chat, optional: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  
end
