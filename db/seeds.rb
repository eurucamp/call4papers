# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

call = Call.first_or_create(:title => "very cool open call", :opens_at => DateTime.now, :closes_at => 3.days.from_now)
call = Call.first_or_create(:title => "very cool closed call", :closes_at => 3.days.ago)

admins = []
admins << User.create!(:email => "bob@example.com", :name => "Bob Example", :staff => true, :password => "12345678")
admins << User.create!(:email => "alice@example.com", :name => "Alice Example", :staff => true, :password => "12345678")

proposals = []

admins.each do |a|
  proposals << a.proposals.create!(:title => "My fancy paper", :public_description => "Very cool paper", :private_description => "In private: it sucks", :terms_and_conditions => "1", :call => call, :time_slot => "15 Minutes")
end

proposals.each do |p|
  admins.each do |a|
    user_proposal_rating = p.user_proposal_ratings.create!(:user => a)
    RatingDimension.all.each do |d|
      user_proposal_rating.ratings << Rating.new(:rating_dimension => d, :vote => rand(3))
    end
    user_proposal_rating.save!
  end
end
