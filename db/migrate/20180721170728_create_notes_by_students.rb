class CreateNotesByStudents < ActiveRecord::Migration[5.0]
  def change
    create_view :notes_by_students
  end
end
