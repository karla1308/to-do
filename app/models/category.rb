class Category < ApplicationRecord
  #each category belongs to a user
  belongs_to :user

  #a category has many todos and will destroy associated todos if the category is deleted
  has_many :todos, dependent: :destroy

  #validate that the category has a name and that it's unique within the scope of the user
  validates :name, presence: true, uniqueness: { scope: :user_id }
end
