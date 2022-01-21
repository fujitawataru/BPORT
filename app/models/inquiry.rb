class Inquiry < ApplicationRecord
  
  validates :name,
  length: { minimum: 1, maximum: 20 }
  
  validates :email,
  length: { minimum: 1}
  
  validates :message,
  length: { minimum: 1, maximum: 200 }
  
  enum subject: { not_clear: 0, improvement: 1, other_users: 2, other: 3}
  
end
