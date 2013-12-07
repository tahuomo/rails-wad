require 'spec_helper'

describe "Beer" do
  include OwnTestHelper

  let!(:user) { FactoryGirl.create :user }
  let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }

  before :each do
    sign_in "Pekka", "foobar1"
  end

  it "when created by user, will be saved to database" do
    visit new_beer_path
    fill_in('beer_name', :with => 'III')
    select("Lager", :from => 'beer_style')
    select(brewery.name, :from => 'beer_brewery_id')


    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

    expect(brewery.beers.count).to eq(1)
  end





end