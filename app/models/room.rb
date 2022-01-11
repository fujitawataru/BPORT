class Room < ApplicationRecord

  has_many :chats, dependent: :destroy
  has_many :entries, dependent: :destroy
  #has_many :users, through: :entries, source: :user #マイページにDM履歴リンク作成のため追加


end
