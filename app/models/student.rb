class Student < ApplicationRecord
  has_many :notes
  has_and_belongs_to_many :courses
  has_many :notes_by_students
end
