class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_many :categories, dependent: :destroy
  has_many :posts, through: :categories, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: { case_sensitive: false }

  def full_name
    "#{first_name} #{last_name}"
  end

  def generate_jwt
    token, _payload = Warden::JWTAuth::UserEncoder.new.call(self, :user, nil)
    token
  end
end
