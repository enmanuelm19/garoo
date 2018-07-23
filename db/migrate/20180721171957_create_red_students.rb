class CreateRedStudents < ActiveRecord::Migration[5.0]
  def change
    create_view :red_students
  end
end
