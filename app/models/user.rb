class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable

  # アソシエーション
  has_many :sns_credentials
  has_many :exhibited_products, class_name: 'Product', foreign_key: :exhibitor_id
  has_many :purchased_products, class_name: 'Product', foreign_key: :purchaser_id

  # 都道府県
  enum address_prefecture: {
  北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
  茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
  新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
  岐阜県:21,静岡県:22,愛知県:23,三重県:24,
  滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
  鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
  徳島県:36,香川県:37,愛媛県:38,高知県:39,
  福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }



  # バリデーション
  VALID_EMAIL_REGEX =                 /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX =                 /\A\d{10}$|^\d{11}\z/
  VALID_ADDRESS_NUMBER_REGEX =        /\A[0-9]{3}-[0-9]{4}\z/
  validates :nickname,                presence: true, length: {maximum: 20}
  validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,                presence: true, length: {minimum: 6, maximum: 128},on: :save_to_session_before_phone
  validates :password_confirmation,   presence: true, length: {minimum: 6, maximum: 128},on: :save_to_session_before_phone
  validates :password,                length: {minimum: 6, maximum: 128},on: :update,allow_blank: true
  validates :password_confirmation,   length: {minimum: 6, maximum: 128},on: :update,allow_blank: true
  validates :last_name,               presence: true
  validates :first_name,              presence: true
  validates :last_name_kana,          presence: true
  validates :first_name_kana,         presence: true
  validates :birthdate_year,          presence: true
  validates :birthdate_month,         presence: true
  validates :birthdate_day,           presence: true
  validates :phone_number,            presence: true, uniqueness: true, format: { with: VALID_PHONE_REGEX }
  validates :address_last_name,       presence: true
  validates :address_first_name,      presence: true
  validates :address_last_name_kana,  presence: true
  validates :address_first_name_kana, presence: true
  validates :address_number,          presence: true, format: { with: VALID_ADDRESS_NUMBER_REGEX }
  validates :address_prefecture,      presence: true
  validates :address_name,            presence: true
  validates :address_block,           presence: true
  validates :address_phone_number,    allow_blank: true, format: { with: VALID_PHONE_REGEX }
end