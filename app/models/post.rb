class Post < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  has_many :comments, dependent: :destroy

  def self.search(keyword)
    #9,10行だとArgumentError (wrong number of arguments (given 0, expected 1)):というエラー表示
    #return Post.all unless search
    #Post.where(["title like? OR text like?", "%#{keyword}%", "%#{keyword}%"])
    where(["title like? OR text like?", "%#{keyword}%", "%#{keyword}%"])
  end

end
