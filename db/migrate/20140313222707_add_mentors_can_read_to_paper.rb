class AddMentorsCanReadToPaper < ActiveRecord::Migration
  def change
    add_column :papers, :mentors_can_read, :boolean, default: true
    add_index :papers, :mentors_can_read
  end
end
