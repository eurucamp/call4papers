class AddTrackToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :time_slot, :string
  end
end
