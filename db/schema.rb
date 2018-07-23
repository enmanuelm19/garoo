# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_07_21_172438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "courses_students", id: false, force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "student_id", null: false
    t.index ["course_id", "student_id"], name: "index_courses_students_on_course_id_and_student_id"
  end

  create_table "notes", force: :cascade do |t|
    t.decimal "note"
    t.bigint "test_id"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_notes_on_student_id"
    t.index ["test_id"], name: "index_notes_on_test_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string "name"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_tests_on_course_id"
  end

  add_foreign_key "courses", "teachers"
  add_foreign_key "notes", "students"
  add_foreign_key "notes", "tests"
  add_foreign_key "tests", "courses"

  create_view "notes_by_students",  sql_definition: <<-SQL
      SELECT t.course_id,
      n.student_id,
      avg(n.note) AS average
     FROM ((notes n
       LEFT JOIN tests t ON ((t.id = n.test_id)))
       LEFT JOIN students s ON ((s.id = n.student_id)))
    GROUP BY t.course_id, n.student_id
    ORDER BY t.course_id;
  SQL

  create_view "red_students",  sql_definition: <<-SQL
      SELECT stu.id,
      stu.name,
      stu.created_at,
      stu.updated_at
     FROM (students stu
       LEFT JOIN ( SELECT st.id,
              count(a.course_id) AS number_of_courses
             FROM (students st
               LEFT JOIN notes_by_students a ON ((a.student_id = st.id)))
            WHERE (a.average < (4)::numeric)
            GROUP BY st.id
            ORDER BY st.id) b ON ((b.id = stu.id)))
    WHERE (b.number_of_courses > 1);
  SQL

end
