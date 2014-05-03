class AddArchivedFlagToCall < ActiveRecord::Migration
  def change
    add_column :calls, :archived, :boolean
 
    Call.all { |c| c.archived = false; c.save }
  end
end
