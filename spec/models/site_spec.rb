require 'rails_helper'

describe Site, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to allow_value(Faker::Internet.url).for(:url) }
    it { is_expected.not_to allow_value(Faker::Lorem.word).for(:url) }
  end

  describe 'url normalization' do
    context 'when a valid url is passed' do
      let(:site) { build(:site) }

      it 'must be stripped' do
        site.valid?
        expect(site.url).to eq site.url.strip
      end
    end

    context 'when a valid whitespace surrounded url is passed' do
      let(:site) { build(:site, url: " #{Faker::Internet.url} ") }

      it 'must be stripped' do
        site.valid?
        expect(site.url).to eq site.url.strip
      end
    end

    context 'when an invalid url is passed' do
      let(:site) { build(:site, url: Faker::Lorem.word) }

      it 'must be stripped' do
        site.valid?
        expect(site.url).to eq site.url.strip
      end
    end

    context 'when an invalid whitespace surrounded url is passed' do
      let(:site) { build(:site, url: " #{Faker::Lorem.word} ") }

      it 'must be stripped' do
        site.valid?
        expect(site.url).to eq site.url.strip
      end
    end
  end

  describe 'shorten_url generation' do
    context 'when a valid url is passed' do
      let(:site) { build(:site) }
      let(:expected_shorten_url) do
        UniqueIdentifierGenerator.generate_for_id(id: site.id)
      end

      it 'must call the UniqueIdentifierGenerator' do
        expect(UniqueIdentifierGenerator).to receive(:generate_for_id).and_call_original.once
        site.save
      end

      it 'must generate the shorten url' do
        site.save
        expect(site.shorten_url).to eq expected_shorten_url
      end
    end

    context 'when an invalid url is passed' do
      let(:site) { build(:site, url: Faker::Lorem.word) }

      it 'must not call the UniqueIdentifierGenerator' do
        expect(UniqueIdentifierGenerator).not_to receive(:generate_for_id)
        site.save
      end

      it 'must not generate the shorten url' do
        site.save
        expect(site.shorten_url).to be nil
      end
    end
  end
end
