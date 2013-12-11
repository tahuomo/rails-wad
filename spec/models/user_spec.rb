require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new :username => "Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a proper password" do
    user = User.create :username => "Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved if password too short" do
    user = User.create :username => "Pekka", :password => "s1", :password_confirmation => "s1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved if password confirmation fails" do
    user = User.create :username => "Pekka", :password => "secret1", :password_confirmation => "secret2"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved if password contains only letters" do
    user = User.create :username => "Pekka", :password => "huijaripuijari", :password_confirmation => "huijaripuijari"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating 10, user

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings 10, 20, 15, 7, 9, user
      best = create_beer_with_rating 25, user

      expect(user.favorite_beer).to eq(best)
    end
  end




  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_style
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      style = FactoryGirl.create(:style, :name => "Weizen")
      create_beer_with_rating_and_style 10, style, user

      expect(user.favorite_style.name).to eq("Weizen")
    end

    it "is the one with highest average rating if several rated" do
      style = FactoryGirl.create(:style, :name => "IPA")
      style2 = FactoryGirl.create(:style, :name => "IPA")
      create_beer_with_rating_and_style 13, style, user
      create_beer_with_rating_and_style 11, style, user
      create_beer_with_rating_and_style 15, style2, user
      create_beer_with_rating_and_style 2, style2, user

      expect(user.favorite_style.name).to eq("IPA")
    end
  end

  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_brewery
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only with ratings if only one rating" do
      create_beer_with_rating 10, user

      expect(user.favorite_brewery.name).to eq("anonymous")
    end

    it "is the one with highest average rating if several rated" do
      create_beers_with_ratings_and_brewery 15, 5, user, "Porin panimo"
      create_beers_with_ratings_and_brewery 12, 14, user, "Kumpulan panimo"

      expect(user.favorite_brewery.name).to eq("Kumpulan panimo")
    end
  end

  def create_beers_with_ratings_and_brewery(*scores, user, brewery)
    brewery = FactoryGirl.create(:brewery, :name => brewery)
    scores.each do |score|
      create_beer_with_rating_and_brewery score, user, brewery
    end
  end

  def create_beer_with_rating_and_brewery(score, user, brewery)
    beer = FactoryGirl.create(:beer, :brewery => brewery, :style => FactoryGirl.create(:style))
    FactoryGirl.create(:rating, :score => score,  :beer => beer, :user => user)
    beer
  end


  def create_beer_with_rating_and_style(score, style,  user)
    beer = FactoryGirl.create(:beer, :style => style)
    FactoryGirl.create(:rating, :score => score,  :beer => beer, :user => user)
    beer
  end

  def create_beers_with_ratings(*scores, user)
    scores.each do |score|
      create_beer_with_rating score, user
    end
  end


  def create_beer_with_rating(score,  user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, :score => score,  :beer => beer, :user => user)
    beer
  end
end
