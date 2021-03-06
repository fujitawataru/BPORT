class RoomsController < ApplicationController

  before_action :authenticate_user!
  def create
    @room = Room.create
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @chats = @room.chats
      @chat = Chat.new
      @entries = @room.entries
      
      @currentEntries = current_user.entries
       myRoomIds = []

      @currentEntries.each do |entry|
       myRoomIds << entry.room.id
      end
      @anotherEntries = Entry.where(room_id: myRoomIds).where.not(user_id: current_user.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @rooms = Room.all
    @entries = Entry.all
    @user = current_user
    @currentEntries = current_user.entries
    myRoomIds = []

    @currentEntries.each do |entry|
     myRoomIds << entry.room.id
    end

    @anotherEntries = Entry.where(room_id: myRoomIds).where.not(user_id: current_user.id)
  end

end
