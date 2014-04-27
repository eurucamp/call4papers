class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.integer :sender_id
      t.string :subject
      t.text :body
      t.datetime :sent_at

      t.timestamps
    end

    add_index :communications, :sender_id
    add_index :communications, :created_at
  end
end
