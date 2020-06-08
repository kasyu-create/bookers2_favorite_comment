class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    #createアクションが実行され、送られてきた、bookのIDを受け取っている
    favorite = current_user.favorites.new(book_id: book.id)
    #ログインしているユーザーのfavoritesの新しいテーブルが発行される。???ここでfavoritesテーブルのuser.idが作られているのか？???current_userとはここでは何を表しているのか。???book_id: book.idとは何か。
    favorite.save
    #book_id,user_idがそれぞれ作られテーブルが完成したのでセーブされる
    redirect_back(fallback_location: root_path)
    #redirect_back(fallback_location:path名）はデータがデータベース名に保存されたら、前のページに戻るように設定
  end

  def destroy
    book = Book.find(params[:book_id])
    #この場合booksのshowでbook_favorites_path(@book)というパス名でDELETEアクションが実行されている。それを実行すると、rails routesではfavorites#destroyが実行されるとなってる為、回ってきたIDをここで受け取っている。
    favorite = current_user.favorites.find_by(book_id: book.id)
    # ???何をいっているのか
    favorite.destroy
    #そのfavoritesテーブルを削除する
    redirect_back(fallback_location: books_path)
    #前述。redirect_back(fallback_location:path名）はデータがデータベース名に保存されたら、前のページに戻るように設定
  end

end
