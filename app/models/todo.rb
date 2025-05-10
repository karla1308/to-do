class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :category
  
  validates :title, presence: true
  validates :priority, inclusion: { in: [true, false] }
  validates :completed, inclusion: { in: [true, false] }
  validates :category, presence: true
end