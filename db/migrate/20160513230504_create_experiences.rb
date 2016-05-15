class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :title
      t.date :begin_date
      t.date :end_date
      t.text :achievements

      t.timestamps null: false
    end
  end
end
