class User < ApplicationRecord
  #use bcrypt for secure password handling
  has_secure_password
  
  #a user has many categories and todos; they will be deleted if the user is deleted
  has_many :categories, dependent: :destroy
  has_many :todos, dependent: :destroy

  #validate presence of first and last name
  validates :first_name, :last_name, presence: true
  
  #validate presence and uniqueness of username
  validates :username, presence: true, uniqueness: true
  
  #validate presence, uniqueness, and proper format of email
  validates :email, presence: true, 
                    uniqueness: true, 
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
  
  #validate password length (minimum 6 characters) on creation or when password is set
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
