class PapersRemoveBioDescriptionEmail < ActiveRecord::Migration
  def change
    change_table :papers do |t|
      t.remove :description, :bio, :email
    end
  end
end
