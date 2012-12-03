class PapersPublicDescriptionDropNullConstraint < ActiveRecord::Migration
  def change
    change_column :papers, :public_description, :text, :null => true
  end
end
