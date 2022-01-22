class Inquiry < ApplicationRecord
  
  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true
  
  enum subject: { not_clear: 0, improvement: 1, other_users: 2, other: 3}
  
end
