class PapersAddUserId < ActiveRecord::Migration
  def up
    add_column :papers, :user_id, :integer, null: false
  end
end
