class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks, :id => false do |t|
      t.string :id, :null => false
      t.string :title
      t.string :public_description
      t.string :private_description
      t.boolean :selected
      t.string :time_slot
      t.string :track
      t.string :mentor_name
      t.boolean :mentors_can_read

      t.timestamps null: false
    end
  end
end
