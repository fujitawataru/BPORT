class ChatsController < ApplicationController

  before_action :authenticate_user!, :only => [:create]

  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:chat][:room_id]).present?
      @chat = Chat.create(params.require(:chat).permit(:user_id, :message, :room_id).merge(:user_id => current_user.id))
      @room=@chat.room
      #通知レコード作成
      #DMされたユーザのentry_idを取得
      @roommembernotme=Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
      @theid=@roommembernotme.find_by(room_id: @room.id)
            notification = current_user.active_notifications.new(
                room_id: @room.id,
                chat_id: @chat.id,
                visited_id: @theid.user_id,
                visitor_id: current_user.id,
                action: 'dm'
            )
            # 自分の投稿に対するコメントの場合は、通知済みとする
            if notification.visitor_id == notification.visited_id
                notification.checked = true
            end
            notification.save if notification.valid?
      # @room.create_notification_chat!(current_user, @chat.id) #通知機能のため
            redirect_to "/rooms/#{@chat.room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    chat = Chat.find(params[:id])
    chat.destroy
    redirect_to request.referer
  end

end
