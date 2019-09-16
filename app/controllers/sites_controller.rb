class SitesController < ApplicationController

  def index
    Site.all.order(visits_count: :desc).limit(100)
  end

  def visit
    url = Site.find_by!(shorten_url: params[:url_hash]).url
    redirect_to url, status: :moved_permanently
  rescue StandardError => e
    render json: { error: e.message }.to_json, status: :not_found
  end

  def create
    shorten_url = Site.create!(url: params[:url]).shorten_url
    render json: { shorten_url: shorten_url }, status: :created
  rescue StandardError => e
    render json: { error: e.message }.to_json, status: :unprocessable_entity
  end
end
