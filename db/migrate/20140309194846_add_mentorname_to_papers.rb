class AddMentornameToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :mentor_name, :string
  end
end
