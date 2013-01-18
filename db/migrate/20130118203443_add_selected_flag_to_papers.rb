class AddSelectedFlagToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :selected, :boolean, :default => false, :null => false
  end
end
