class Room < ApplicationRecord

  has_many :chats, dependent: :destroy
  has_many :entries, dependent: :destroy
  #has_many :users, through: :entries, source: :user #マイページにDM履歴リンク作成のため追加
  has_many :notifications, dependent: :destroy

# #通知メソッド
#   def create_notification_chat!(current_user, chat_id)

#     roommembernotme=Entry.where(room_id: id).where.not(user_id: current_user.id)
#     theid=roommembernotme.find_by(room_id: id)
#     save_notification_comment!(current_user, chat_id)
#     end

#   def save_notification_comment!(current_user, chat_id, visited_id) #wrong number of arguments (given 2, expected 3)
#     notification = current_user.active_notifications.new(
#                 room_id: id,
#                 chat_id: chat.id,
#                 visited_id: visited_id,
#                 visitor_id: current_user.id,
#                 action: 'dm'
#     )
#     # 自分の投稿に対するコメントの場合は、通知済みとする
#     if notification.visitor_id == notification.visited_id
#       notification.checked = true
#     end
#     notification.save if notification.valid?
#     end
end
