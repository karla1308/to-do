class User < ApplicationRecord
  has_secure_password
  has_many :categories, dependent: :destroy
  has_many :todos, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, 
                    uniqueness: true, 
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end