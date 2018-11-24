class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_actionで下で定義したメソッドを実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  #変数PERMISSIBLE_ATTRIBUTESに配列[:name]を代入
  # PERMISSIBLE_ATTRIBUTES = %i(name,company_name,department)



# helper_method :current_user, :logged_in?


  PERMISSIBLE_ATTRIBUTES = %i(name avatar avatar_cache company_name department)
  protected

    #deviseのストロングパラメーターにカラム追加するメソッドを定義
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: PERMISSIBLE_ATTRIBUTES)
      devise_parameter_sanitizer.permit(:account_update, keys: PERMISSIBLE_ATTRIBUTES)
    end

  add_flash_types :success, :info, :warning, :danger
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # DIVE19-2
  before_action :current_notifications, if: :signed_in?
  def current_notifications
   @notifications_count = Notification.where(user_id: current_user.id).where(read: false).count
  end

# private
# def current_user
#    return unless session[:user_id]
#    @current_user ||= User.find(session[:user_id])
#    end
# #
# def logged_in?
#     !!session[:user_id]
# end

# def authenticate
#   return if logged_in?
#    redirect_to root_path,alert: 'ログインしてください'
# end

end
