class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  
  has_many :comments, dependent: :destroy
  
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  
  has_many :entries, dependent: :destroy
  has_many :chats, dependent: :destroy
  #has_many :rooms, through: :entries, source: :room #マイページにDM履歴リンク作成のため追加

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  attachment :image

  enum area:{
    "---":0,
     北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
     茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
     新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
     岐阜県:21,静岡県:22,愛知県:23,三重県:24,
     滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
     鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
     徳島県:36,香川県:37,愛媛県:38,高知県:39,
     福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
    },_suffix: true

    enum category:{
    "---":0,
     農業:1,林業:2,水産業:3,漁業:4,水産養殖業:5,金属鉱業:6,石炭・亜炭工業:7,
     原油・天然ガス鉱業:8,非金属鉱業:9,総合工事業:10,職別工事業:11,設備工事業:12,食料品製造業:13,飲料・飼料製造業:14,
     繊維工業:15,他繊維製品製造:16,木材木製品製造:17,家具・装備品:18,パルプ・紙製造:19,出版・印刷:20,
     化学工業:21,石油・石炭製品:22,プラ製品製造業:23,ゴム製品製造業:24,
     革・毛皮製造業:25,窒素・土石製品:26,輸送用機械器具:27,精密機械器具:28,武器製造業:29,その他製造業:30,
     電気業:31,ガス業:32,熱供給業:33,水道業:34,鉄道業:35,
     道路旅客運送業:36,道路貨物運送業:37,水運業:38,航空運送業:39,
     倉庫業:40,運輸サービス:41,運輸サービス:42,通信業:43,各種商品卸売業:44,繊・機・建材卸:45,衣・食・家具卸:46,
     代理商・中立業:47,各種商品小売業:48,織物衣料小売業:49,飲食料小売業:50,自動車小売業:51,自動車小売業:52,家具建具小売業:53,
     その他小売業:54,一般飲食店:55,その他飲食店:56,銀行・信託業:57,農水産金融業:58,中小企業金融業:59,金融付帯業:60,投資業:61,
     証券・商品取引:62,保険業:63,保健代理業:64,不動産取引業:65,不動産賃貸業:66,物品賃貸業:67,
    },_suffix: true
end
