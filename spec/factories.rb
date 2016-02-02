FactoryGirl.define do
  factory :game do
    home_team "NYG"
    away_team "NYJ"
  end
end

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Ari#{n}" }
    email { "#{name}@me.com" }
    password "123456a"
    role "regular"

    factory :admin do
      role "admin"
    end
  end
end

FactoryGirl.define do
  factory :box do
    game
  end
end

FactoryGirl.define do
  factory :score do
    home_score 33
    away_score 27
    quarter 4
    game_info "CAR vs DB"
  end
end