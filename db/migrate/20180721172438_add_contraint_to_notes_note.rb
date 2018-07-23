class AddContraintToNotesNote < ActiveRecord::Migration[5.2]
  def up
    execute(%q{
      ALTER TABLE notes ADD CONSTRAINT check_note CHECK(note >= 1.0 AND note <= 7.0)
    })
  end

  def down
    execute(%q{
      ALTER TABLE notes DROP CONSTRAINT check_note
    })
  end
end
