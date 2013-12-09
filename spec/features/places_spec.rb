require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return( [  Place.new(:name => "Oljenkorsi") ] )

    visit places_path
    fill_in('city', :with => 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple returned by the API, all are shown on the same page" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return([Place.new(:name => "Oljenkorsi"),
                                                                Place.new(:name => "Hilpeä hauki"),
                                                                Place.new(:name => "Llamas")] )

    visit places_path
    fill_in('city', :with => 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Hilpeä hauki"
    expect(page).to have_content "Llamas"
  end

  it "if no places returned by the API, notification is displayed" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return([])

    visit places_path
    fill_in('city', :with => 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end