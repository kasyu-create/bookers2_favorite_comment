class UsersController < ApplicationController
	before_action :baria_user, only: [:edit, :update]
  #下記記述
  def show
  	@user = User.find(params[:id])
  	@books = @user.books
			#userテーブルにbooksカラムなどないのに。.booksとは何か
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to @user, notice: "successfully updated user!"
	else
  		render "edit"
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
		#unlessはfalseの時に実行する文。なので、params[:id].to_i == current_user.idが同じではなかった場合、レダイレクトされる。この場合だとログインしたユーザーのIDが違うユーザーのIDにログインした場合、自分のログインしているURLに戻されるという事。
		#それをbefore_actionで定義している。今回はeditとupdateアクションのみ実行される
   end

end
