class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.string    :title,       null: false
      t.text      :description
      t.text      :instructions
      t.string    :website_url
      t.datetime  :opens_at
      t.datetime  :closes_at,   null: false

      t.timestamps
    end

    add_index :calls, :title, unique: true
  end
end
