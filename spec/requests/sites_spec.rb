require 'rails_helper'

describe 'Sites', type: :request do
  describe 'GET /:url_hash' do
    context 'when passing an existent shortened url' do
      let(:site) { create(:site, url: 'www.google.com') }

      it 'must have status 301' do
        get "/#{site.shorten_url}"
        expect(response).to have_http_status :moved_permanently
      end

      it 'must be redirected to the real site' do
        get "/#{site.shorten_url}"
        expect(response).to redirect_to(site.url)
      end
    end

    context 'when passing an existent shortened url' do
      let(:site) { create(:site, url: 'www.google.com') }

      it 'must have status 404' do
        get "/#{Faker::Lorem.word}"
        expect(response).to have_http_status :not_found
      end

      it 'must retrieve an error' do
        get "/#{Faker::Lorem.word}"
        json = JSON.parse(response.body)
        expect(json).to have_key 'error'
      end

      it 'must retrieve the specific error' do
        get "/#{Faker::Lorem.word}"
        json = JSON.parse(response.body)
        expect(json['error']).to eq "Couldn't find Site"
      end
    end
  end

  describe 'POST /' do
    context 'when passing a valid url' do
      let(:url) { Faker::Internet.url }

      it 'must have status 201' do
        post '/', params: { url: url }
        expect(response).to have_http_status :created
      end

      it 'must retrieve the shortened url' do
        post '/', params: { url: url }
        json = JSON.parse(response.body)
        expect(json).to have_key 'shorten_url'
      end
    end

    context 'when passing an empty url' do
      let(:url) { nil }

      it 'must not create the new site' do
        post '/', params: { url: url }
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'must retrieve an error' do
        post '/', params: { url: url }
        json = JSON.parse(response.body)
        expect(json).to have_key 'error'
      end

      it 'must retrieve the specific error' do
        post '/', params: { url: url }
        json = JSON.parse(response.body)
        expect(json['error']).to eq "Validation failed: Url can't be blank"
      end
    end

    context 'when passing an invalid url' do
      let(:url) { Faker::Lorem.word }

      it 'must not create the new site' do
        post '/', params: { url: url }
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'must retrieve an error' do
        post '/', params: { url: url }
        json = JSON.parse(response.body)
        expect(json).to have_key 'error'
      end

      it 'must retrieve the specific error' do
        post '/', params: { url: url }
        json = JSON.parse(response.body)
        expect(json['error']).to eq 'Validation failed: Url is invalid'
      end
    end
  end
end
