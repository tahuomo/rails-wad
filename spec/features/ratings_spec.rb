require 'spec_helper'

describe "Rating" do
  include OwnTestHelper

  let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }
  let!(:style) { FactoryGirl.create :style }
  let!(:beer1) { FactoryGirl.create :beer, :name => "iso 3", :brewery => brewery , :style => style}
  let!(:beer2) { FactoryGirl.create :beer, :name => "Karhu", :brewery => brewery,  :style => style}
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in "Pekka", "foobar1"
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select(beer1.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "when given, are seen on the ratings page" do
    FactoryGirl.create(:rating, :score => "15",  :beer => beer1, :user => user)
    FactoryGirl.create(:rating, :score => "25",  :beer => beer2, :user => user)


    visit ratings_path
    expect(page).to have_content "ratings: 2"
    expect(page).to have_content "Karhu, Koff 25"
    expect(page).to have_content "iso 3, Koff 15"
  end

  it "can be seen on the owners page" do
    FactoryGirl.create(:rating, :score => "15",  :beer => beer1, :user => user)

    visit user_path(user)
    expect(page).to have_content "iso 3 15"
  end

  it "won't show on different user's page" do
    FactoryGirl.create(:rating, :score => "25",  :beer => beer2, :user => FactoryGirl.create(:user, :username => "Matti"))

    visit user_path(user)
    expect(page).to_not have_content "Karhu 25"
  end

  it "when deleted, will be removed from database" do
    FactoryGirl.create(:rating, :score => "15",  :beer => beer1, :user => user)

    visit user_path(user)
    expect{
      click_link "delete"
    }.to change{Rating.count}.from(1).to(0)

    expect(user.ratings.count).to eq(0)
    expect(beer1.ratings.count).to eq(0)
  end

end