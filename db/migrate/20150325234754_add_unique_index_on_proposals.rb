class AddUniqueIndexOnProposals < ActiveRecord::Migration
  def change
    add_index :proposals, [:talk_id, :call_id], unique: true
  end
end
