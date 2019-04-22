class User < ApplicationRecord
  has_many :user_groups
  has_many :groups, through: :user_groups

  has_secure_password

  validates :email, presence: false, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }
  validates :username, uniqueness: true
  validates :admin, inclusion: { in: [true, false]}
end
