require "away/models"

FactoryGirl.define do
  factory :extra

  factory :hotel do
    name "My Hotel"
  end

  factory :hotel_with_extras, class: Hotel do
    name "My Hotel with Extras"
    after(:create) do |hotel, evaluator|
      create_list(:extra, 3, hotel: hotel)
    end
  end
end
