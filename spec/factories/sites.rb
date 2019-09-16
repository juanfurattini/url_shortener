FactoryBot.define do
  factory :site, class: Site do
    url { Faker::Internet.url }
  end
end
