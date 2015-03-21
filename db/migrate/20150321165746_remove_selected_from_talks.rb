class RemoveSelectedFromTalks < ActiveRecord::Migration
  def change
    remove_column :talks, :selected, :boolean
  end
end
