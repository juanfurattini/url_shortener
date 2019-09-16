require 'rails_helper'

describe SiteVisit, type: :model do
  describe 'Relationships' do
    it { is_expected.to belong_to(:site).class_name('Site').counter_cache(:visits_count) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:site) }
    it { is_expected.to allow_value(Faker::Internet.ip_v4_address).for(:ip_address) }
    it { is_expected.not_to allow_value(Faker::Lorem.word).for(:ip_address) }
  end
end
