FactoryGirl.define do
  factory :game do
    home_team "NYG"
    away_team "NYJ"
  end
end

FactoryGirl.define do
  factory :user do
    name "Ari"
    email { "#{name}@me.com" }
    password "123456a"
  end
end

FactoryGirl.define do
  factory :box do

  end
end

FactoryGirl.define do
  factory :score do
    home_score 33
    away_score 27
    quarter "fourth"
  end
end