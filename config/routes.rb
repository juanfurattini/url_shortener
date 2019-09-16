Rails.application.routes.draw do
  # Index page
  get '/', to: 'sites#index', as: 'index'
  # Link to the shortened url
  get '/:url_hash', to: 'sites#visit', as: 'visit_site'
  # Create new Site (shorten url)
  post '/', to: 'sites#create', as: 'create_site'
end
