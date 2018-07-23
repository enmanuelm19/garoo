# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.fi
(1..3).each { |i| Teacher.create(name: "Profesor #{i}") }
(1..5).each { |i| Course.create(name: "Course #{i}", teacher: Teacher.take(1).first) }
(1..10).each { |i| Test.create(name: "Test #{i}", course: Course.take(1).first) }
(1..20).each { |i| Student.create(name: "Student #{i}") }

Student.all.each do |student|
  student.course_ids = Course.limit(3).ids
  student.save
end
