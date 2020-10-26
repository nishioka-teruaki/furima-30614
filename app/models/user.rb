class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/.freeze # 全角ひらがな漢字
  VALID_NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze # 全角カタカナ
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze # 英数字混合

  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: VALID_NAME_REGEX }
    validates :first_name, format: { with: VALID_NAME_REGEX }
    validates :last_name_kana, format: { with: VALID_NAME_KANA_REGEX }
    validates :first_name_kana, format: { with: VALID_NAME_KANA_REGEX }
    validates :user_birth_date
    validates :password, format: { with: VALID_PASSWORD_REGEX }
  end

  has_many :items
end
