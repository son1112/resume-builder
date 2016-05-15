class AddSkillsToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :skills, :text
  end
end
