class AddPhaseToCall < ActiveRecord::Migration
  def change
    add_column :calls, :phase, :string
  end
end
