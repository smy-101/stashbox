class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || password.present? }

  def generate_jwt
    payload = { user_id: self.id }
    JWT.encode payload, Rails.application.credentials.secret_key_base, "HS256"
  end

  def generate_auth_header
    { Authorization: "Bearer #{self.generate_jwt}" }
  end
end
