class AddTimeSlotToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :track, :string
  end
end
