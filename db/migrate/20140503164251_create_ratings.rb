class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_paper_rating_id, null: false
      t.integer :rating_dimension_id, null: false
      t.integer :vote
      t.text :notes

      t.timestamps
    end

    add_index :ratings, [:user_paper_rating_id, :rating_dimension_id], unique: true
  end
end
