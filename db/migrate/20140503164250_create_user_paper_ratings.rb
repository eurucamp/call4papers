class CreateUserPaperRatings < ActiveRecord::Migration
  def change
    create_table :user_paper_ratings do |t|
      t.integer :user_id, null: false
      t.string :paper_id, null: false

      t.timestamps
    end
    add_index :user_paper_ratings, [:user_id, :paper_id], unique: true
  end
end
