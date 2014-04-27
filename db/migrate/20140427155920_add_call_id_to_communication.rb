class AddCallIdToCommunication < ActiveRecord::Migration
  def change
    add_column :communications, :call_id, :integer
  end
end
