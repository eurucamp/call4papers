class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,  null: false
      t.string :email, null: false
      t.text :bio
      t.string :website_url
      t.string :twitter_handle
      t.string :github_handle

      t.timestamps null: false
    end
  end
end
