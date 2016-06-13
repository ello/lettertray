Rails.application.routes.draw do
  get '/messages' => 'messages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/email_processor' => 'griddler/emails#create'
end
