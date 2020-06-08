Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  root 'home#top'
  get 'home/about' => 'home#about'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    #親子関係の記述はこのように記述しなければいけないが、それならばuserとbookも親子である為、しなくてもいいのか。このような親子関係をネストするという.必ずこのような記述をする縛りはなく、ある投稿に関連付けられたコメントと認識出来る方が、ユーザーにとって分かりやすい。以下例。
    #book_book_comments POST /books/:book_id/　
    #book_comments(.:format)                              book_comments#create
  end
end
