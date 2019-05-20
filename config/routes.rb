Rails.application.routes.draw do
	root 'messenger#index'
	get 'messenger/save' 
	get 'messenger/longpagesave'
	get 'messenger/sendmessage'
	get 'messenger/show'

	get 'username/collect'
	get 'username/upvote'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
