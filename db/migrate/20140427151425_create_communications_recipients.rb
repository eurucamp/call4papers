class CreateCommunicationsRecipients < ActiveRecord::Migration
  def change
    create_table :communications_recipients, id: false do |t|
      t.integer :communication_id
      t.integer :recipient_id
    end
    add_index :communications_recipients, [:communication_id, :recipient_id], unique: true, name: "c_id_rec_id"
  end
end
