Rails.application.routes.draw do
  # get 'static_pages/help'
  get 'static_pages/proverbs16'
  get 'static_pages/proverbs19'
  get 'static_pages/proverbs21'

	root controller: :static_pages, action: :home

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
