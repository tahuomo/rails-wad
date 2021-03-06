FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "foobar1"
    password_confirmation "foobar1"
  end

  factory :rating, :class => Rating do
    score 10
    beer
  end

  factory :rating2, :class => Rating do
    score 20
    beer
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :style do
    name "Lager"
    description "Yleisin oluttyyppi"
  end

  factory :beer do
    name "anonymous"
    brewery
    style
  end
end