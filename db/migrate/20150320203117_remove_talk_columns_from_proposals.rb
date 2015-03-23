class RemoveTalkColumnsFromProposals < ActiveRecord::Migration
  def change
    remove_column :proposals, :user_id, :integer
    remove_column :proposals, :title, :string
    remove_column :proposals, :public_description, :string
    remove_column :proposals, :private_description, :string
    remove_column :proposals, :time_slot, :string
    remove_column :proposals, :mentor_name, :string
    remove_column :proposals, :mentors_can_read, :boolean
  end
end
