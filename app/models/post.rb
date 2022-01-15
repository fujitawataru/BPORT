class Post < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def self.search(keyword)
    #9,10行だとArgumentError (wrong number of arguments (given 0, expected 1)):というエラー表示
    #return Post.all unless search
    #Post.where(["title like? OR text like?", "%#{keyword}%", "%#{keyword}%"])
    where(["title like? OR text like?", "%#{keyword}%", "%#{keyword}%"])
  end

  def create_notification_comment!(current_user, comment_id)
    #以下のメソッドではログインユーザ以外のコメントしたことのある全てのユーザを検索してしまう
    #temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    #temp_ids.each do |temp_id|
    
    
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id)
  end

    def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
       notification.checked = true
    end
    notification.save if notification.valid?
    end
end