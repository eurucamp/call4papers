class AssociatePapersWithCalls < ActiveRecord::Migration
  def change
    change_table :papers do |t|
      t.belongs_to :call, null: false
    end
  end
end
