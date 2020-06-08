class BooksController < ApplicationController

	before_action :baria_user, only: [:edit, :update]
	#一番下に記述

  def show
	  @book = Book.find(params[:id])
		#送られてきたidを検索してその全ての情報を@bookに格納している。こ　の場合送られて来る場合は、books/3と入力した場合や投稿して自動的　にidが付けられた場合など
		@user = @book.user
		# このbookモデルが所属しているuserモデル
		#？？？受け取ったbook_idに、その後が分からない。.userとは何か
		# →book_idを受け取ったbookテーブルのuser_idを@userに代入しているのか。
	  @new_book = Book.new
		#取り敢えず、新しいBookテーブルを作っている事は分かる。
		@book_comment = BookComment.new
		#取り敢えず、新しいBookCommentテーブルを作っている事は分かる。
		@book_comments = @book.book_comments
		# このbookモデルが持っているbook_comments
		#？？？受け取ったbook_idに、その後が分からない。.book_commnentsとは何か
  end

  def index
		@book = Book.new
		#前述、新しいBookテーブルの作成
  	@books = Book.all
		#一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
	  @book = Book.new(book_params)
		#book_paramsを引数として、（下記で定義されている）新しいBookテーブルの作成している
	  @book.user_id = current_user.id
		#新しく作られるbookテーブルのuser_idはログインしているuserと同じものにするという式。bookテーブルのbook.idは自動で作られるが、bookテーブルのuser_idはこのような式にして作らなければいけない。
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to books_path, notice: "successfully created book!"
			#保存された場合の移動先を指定。
			#でもredirect_toの指定先が＠bookはどこを指してるのか。→新しく@book = Book.new(book_params)で作られたidである。具体的にはbook/idとなる。
			#???しかしidも指定していないのにどうしてそのURLに飛ぶのか
			#どこに飛ばすかによる。サンプル。
  	else
  		@books = Book.all
  		render 'index'
			#indexに戻るアクション。この際を一覧表示を同じように渡さないといけない
  	end
  end

	def edit
		@book = Book.find(params[:id])
		#URLからedit_book_path(@book)と引数にidの入ったpathをparamsで受け取っている。それを検索してその全ての情報を@bookに格納している。
  end

  def update
  	@book = Book.find(params[:id])
		#送られてきたidを検索してその全ての情報を@bookに格納している。
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
		#？？？ここの@bookが何のリンクを表しているかが分からん。
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
		#送られてきたidを検索してその全ての情報を@bookに格納している。
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
		#bookテーブルのtitleカラムとbodyカラムに入力された値のみ許可しますよという意味
  end

  def baria_user
	unless Book.find(params[:id]).user.id.to_i == current_user.id
		redirect_to books_path
	end
	#unlessはfalseの時に実行する文。なので、params[:id].to_i == current_user.idが同じではなかった場合、レダイレクトされる。この場合だとログインしたユーザーのIDが違うユーザーのIDにログインした場合、自分のログインしているURLに戻されるという事。
	#それをbefore_actionで定義している。今回はeditとupdateアクションのみ実行される
 end

end
