class User < ApplicationRecord
  has_many :ads
  has_many :vehicles
  has_many :elds
  belongs_to :company, optional: true
  has_secure_password
  validates_uniqueness_of :username, :email, :nic, :phone

  attribute :active, default: -> { false }

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
