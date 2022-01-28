class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order.per(10)
    @following_users = @user.following_user
    @follower_users = @user.follower_user

    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
      end
    end
    if @isRoom
    else
      @room = Room.new
      @entry = Entry.new
    end
    end

    #@rooms = @user.rooms  #マイページにDM履歴リンク作成のため追加

  end

  def edit
     @user = User.find(params[:id])
     redirect_to user_path(current_user) unless current_user.id == @user.id
  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
    redirect_to user_path(@user.id), notice: 'ユーザ情報を更新しました'
   else
    render :edit
   end
  end

  def follows
   user = User.find(params[:id])
   @users = user.following_user
  end

 def followers
   user = User.find(params[:id])
   @users = user.follower_user
 end


  private

def user_params
  params.require(:user).permit(:name,:introduce,:image,:area,:category)
end

end
