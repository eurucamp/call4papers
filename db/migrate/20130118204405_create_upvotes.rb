class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.integer :user_id,  null: false
      t.string :paper_id, null: false

      t.timestamps null: false
    end
  end
end
