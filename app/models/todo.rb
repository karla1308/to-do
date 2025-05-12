class Todo < ApplicationRecord
  #a todo belongs to a user and a category
  belongs_to :user
  belongs_to :category
  
  #validate that the title is present
  validates :title, presence: true
  
  #rnsure that priority is either true or false
  validates :priority, inclusion: { in: [true, false] }

  #ensure that completed is either true or false
  validates :completed, inclusion: { in: [true, false] }
  
  #validate that a category is associated with the todo
  validates :category, presence: true
end
