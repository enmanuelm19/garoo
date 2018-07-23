class UpdateNotesByStudentsToVersion2 < ActiveRecord::Migration[5.0]
  def change
    update_view :notes_by_students, version: 2, revert_to_version: 1
  end
end
