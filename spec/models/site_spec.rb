require 'rails_helper'

describe Site, type: :model do
  let(:valid_url) { 'www.google.com' }
  let(:invalid_url) { 'some_text' }

  describe 'url validation' do
    let(:site) { build(:site, url: url) }

    context 'when a valid url is passed' do
      let(:url) { valid_url }

      it { expect(site).to be_valid }

      it 'must be stripped' do
        site.valid?
        expect(site.url).to eq url.strip
      end
    end

    context 'when a valid whitespace surrounded url is passed' do
      let(:url) { " #{valid_url} " }

      before { site.valid? }

      it { expect(site).to be_valid }

      it 'must be stripped' do
        site.valid?
        expect(site.url).to eq url.strip
      end
    end

    context 'when an invalid url is passed' do
      let(:url) { invalid_url }

      it { expect(site).not_to be_valid }

      it 'must be stripped' do
        site.valid?
        expect(site.url).to eq url.strip
      end
    end

    context 'when an invalid whitespace surrounded url is passed' do
      let(:url) { " #{invalid_url} " }

      it { expect(site).not_to be_valid }

      it 'must be stripped' do
        site.valid?
        expect(site.url).to eq url.strip
      end
    end
  end

  describe 'shorten_url generation' do
    context 'when a valid url is passed' do
      let(:url) { valid_url }
      let(:site) { create(:site, url: url) }
      let(:expected_shorten_url) do
        UniqueIdentifierGenerator.generate_for_id(id: site.id)
      end

      before do
        expect(UniqueIdentifierGenerator)
          .to receive(:generate_for_id)
          .with(id: site.id).and_call_original
          .once
      end

      it { expect(site.shorten_url).to eq expected_shorten_url }
    end

    context 'when an invalid url is passed' do
      let(:url) { invalid_url }
      let(:site) { build(:site, url: url) }

      before do
        expect(UniqueIdentifierGenerator)
          .not_to receive(:generate_for_id)
      end

      it do
        site.save
        expect(site.shorten_url).to be nil
      end
    end
  end
end
