class AddRatingDimensionsToDatabase < ActiveRecord::Migration
  DimensionNames = [
    'Clarity of the proposal',
    'Originality of content',
    'Originality of presentation',
    'Personal interest',
    'Beginner friendliness',
    'Technical level'
  ]
  def up
    DimensionNames.each do |dimension_name|
      RatingDimension.where(name: dimension_name).first_or_create
    end
  end
  def down
    DimensionNames.each do |dimension_name|
      RatingDimension.where(name: dimension_name).destroy_all
    end
  end
end
