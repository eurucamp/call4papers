class AddUserReferenceToTalk < ActiveRecord::Migration
  def change
    add_reference :talks, :user
  end
end
