class RequirePublicDescriptionInTalks < ActiveRecord::Migration
  def up
    change_column :talks, :public_description, :string, null: false
  end

  def down
    change_column :talks, :public_description, :string, null: true
  end
end
