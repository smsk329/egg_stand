class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  # ログインしたあとの遷移先を指定
  def after_sign_in_path_for(namespace_or_scope)
      if namespace_or_scope.is_a?(Admin)
         admin_customers_path
      else
         root_path
      end
  end

  # ログアウトしたあとの遷移先を指定
  def after_sign_out_path_for(namespace_or_scope)
      if namespace_or_scope == :public
         root_path
      elsif
         namespace_or_scope == :admin
         new_admin_session_path
      else
         root_path
      end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :introduction, :customer_image])
  end

end
