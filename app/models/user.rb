class User < ApplicationRecord
  has_many :reservations, dependent: :destroy
  # 「remember_token」という仮想の属性を作成します。
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  VALID_PASSWORD_REGEX = /\A[a-zA-Z\d]+\z/
  validates :password, presence: true, length: { minimum: 6, maximum: 20 },
                    format: { with: VALID_PASSWORD_REGEX }, allow_nil: true
  
  validate :email_error_msg_make
  validate :password_error_msg_make
  
  def email_error_msg_make
    if errors[:email].any?
      errors.full_messages.each do |msg|
        if msg == "Emailを入力してください"
          errors.messages.delete(:email)
          errors.add(:email, "を入力してください")
        end
      end
    end
  end
  
  def password_error_msg_make
    if errors[:password].any?
      errors.messages.delete(:password) 
      errors.add(:password, "は、半角英数字で6文字以上20文字以内で入力してください") 
    end
  end

  # 渡された文字列のハッシュ値を返します。
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返します。
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためハッシュ化したトークンをデータベースに記憶します。
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token)
    # ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのログイン情報を破棄します。
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # ユーザーを絞り込み検索します。
  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end
end
