class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.integer :user_id
      t.string :paper_id

      t.timestamps
    end

    add_index :notes, :user_id
  end
end
