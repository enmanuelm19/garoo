class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.decimal :note
      t.references :test, foreign_key: true
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
