require 'spec_helper'

describe Beer do
  it "is not saved without a name" do
    beer = Beer.create

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create :name => "Pirkka olut"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end
end
