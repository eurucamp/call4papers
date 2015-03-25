class AddConstraintsAndDefaultsToTalks < ActiveRecord::Migration
  def change
    change_column :talks, :title, :string, null: false
    change_column :talks, :private_description, :string, null: false
    change_column :talks, :user_id, :integer, null: false
    change_column :talks, :mentors_can_read, :boolean, default: true, null: false

    add_index :talks, :mentors_can_read
    add_foreign_key :talks, :users
  end
end
