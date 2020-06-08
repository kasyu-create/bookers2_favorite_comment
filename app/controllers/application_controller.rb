class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	#ログイン済のユーザーのみアクセスを許可する
	before_action :configure_permitted_parameters, if: :devise_controller?
	#デバイス機能実行前にconfigure_permitted_parametersの実行をする。
	protect_from_forgery with: :exception
	#これを記述する事でこのプログラムはcsrfを対策が出来る
	#csrfとは悪意のあるユーザーがサーバーへのリクエストを捏造して正当なものに見せかけ、認証済みユーザーを装うという攻撃手法
  protected
  def after_sign_in_path_for(resource)
		#???(resource)とはどういう意味の引数か
		#devise=モデル管理　resourceはどんなモデルでも対応出来る。管理者や発送人でも行けるように
    user_path(current_user)
		#???(current_user)はどういう意味か
		# resouceでも可
  end

  #sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  def after_sign_out_path_for(resource)
		#???(resource)とはどういう意味の引数か
    user_path(resource)
		#???(resource)はどういう意味か
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    #deviseではサインアップ時にメールアドレスとパスワードのみを受け取るようにストロングパラメーターで設定してある。基本はキーを追加しても許可されない。しかし、、configure_permitted_parameterメソッドを使うと、sign_upの際にnameのデータ操作を追加したカラム。
  end
end
