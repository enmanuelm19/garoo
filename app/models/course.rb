class Course < ApplicationRecord
  has_many :tests
  has_and_belongs_to_many :students
  belongs_to :teacher
end
