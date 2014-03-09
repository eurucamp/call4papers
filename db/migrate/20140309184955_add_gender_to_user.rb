class AddGenderToUser < ActiveRecord::Migration
  def change
    add_column :users, :gender, :integer
  end
end
