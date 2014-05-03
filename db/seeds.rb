# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

call = Call.first_or_create(:title => "very cool call", :closes_at => 3.days.ago)

admins = []
admins << User.create!(:email => "some@other.com", :name => "Foo Bar", :staff => true, :password => "12345678")
admins << User.create!(:email => "else@other.com", :name => "Foo Batz", :staff => true, :password => "12345678")

papers = []

admins.each do |a|
  papers << a.papers.create!(:title => "My fancy paper", :public_description => "Very cool paper", :private_description => "In private: it sucks", :terms_and_conditions => "1", :call => call, :time_slot => "15 Minutes")
end

papers.each do |p|
  admins.each do |a|
    user_paper_rating = p.user_paper_ratings.create!(:user => a)
    RatingDimension.all.each do |d|
      user_paper_rating.ratings << Rating.new(:rating_dimension => d, :vote => rand(3))
    end
    user_paper_rating.save!
  end
end
