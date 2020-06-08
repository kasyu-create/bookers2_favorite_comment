class BookCommentsController < ApplicationController

  before_action :baria_user, only: [:destroy]
  #下に記述

  def create
    book = Book.find(params[:book_id])
    #createアクションが実行され、送られてきた、bookのIDを受け取っている
    comment = current_user.book_comments.new(comment_params)
    #ログインしているユーザーのbook_commmentsの新しいテーブルが発行される。???ここでbook_commentテーブルのuser.idが作られているのか？???current_userとはここでは何を表しているのか
    # current_userはcomments.user_idを入力している
    # 新しくcommentを受け取ったcomments
    comment.book_id = book.id
    #新しく作られるbook_commentテーブルのbook_commentのbook_idは受け取ったbook_idと同じにするという式。book_commentテーブルのbook_comment_idは自動で作られるが、book_commentテーブルのbook_commentのbook_idはこのような式にして作らなければいけない。ああややこしい。
    #？？？でもその場合book_commentテーブルのuser.idはどうなるのか？ログインしているユーザーのIDが自動的に作られるのか？
    comment.save
    #book_id,user_id,commentがそれぞれ作られテーブルが完成したのでセーブされる
    redirect_back(fallback_location: books_path)
    #redirect_back(fallback_location:path名）はデータがデータベース名に保存されたら、前のページに戻るように設定
  end

  def destroy
    comment = BookComment.find(params[:id])
    #この場合booksのshowでbook_book_comment_pathというパス名でDELETEアクションが実行されている。それを実行すると、rails routesではbook_comments#destroyが実行されるとなってる為、回ってきたIDをここで受け取っている。
    comment.destroy
    #そのcommentテーブルを削除する
    redirect_back(fallback_location: books_path)
    #前述。redirect_back(fallback_location:path名）はデータがデータベース名に保存されたら、前のページに戻るように設定
  end

  private
  def comment_params
    params.require(:book_comment). permit(:user_id, :book_id, :comment)
    #book_commentテーブルのuser_idカラムとbook_idカラムとcommentカラムに入力された値のみ許可しますよという意味
  end

   def baria_user
    comment = BookComment.find(params[:id])
  	unless comment.user_id == current_user.id
  		redirect_to user_path(current_user)
  	end
    #unlessはfalseの時に実行する文。なので、params[:id].to_i == current_user.idが同じではなかった場合、レダイレクトされる。この場合だとログインしたユーザーのIDが違うユーザーのIDにログインした場合、自分のログインしているURLに戻されるという事。
    #それをbefore_actionで定義している。今回はeditとupdateアクションのみ実行される
   end
end
