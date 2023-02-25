Rails.application.routes.draw do
  get :encodes, action: :encodes, controller: :short_urls
  get :decodes, action: :decodes, controller: :short_urls
  post :encode, action: :encode, controller: :short_urls
  patch :decode, action: :decode, controller: :short_urls

  root 'short_urls#encodes'
end
