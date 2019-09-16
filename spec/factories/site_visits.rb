FactoryBot.define do
  factory :site_visit, class: SiteVisit do
    site
    ip_address { Faker::Internet.ip_v4_address }
  end
end
