class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" #[class_name: "User"]を加え、参照するテーブルの所属先を指定
  belongs_to :followed, class_name: "User"
end
