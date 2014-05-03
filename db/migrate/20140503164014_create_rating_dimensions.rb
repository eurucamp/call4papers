class CreateRatingDimensions < ActiveRecord::Migration
  def change
    create_table :rating_dimensions do |t|
      t.string :name

      t.timestamps
    end
  end
end
