class Api::BaseController < ActionController::Base
  # include DeviseTokenAuth::Concerns::SetUserByToken
  #
  # before_action :authenticate_user!
  #
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  # end

  # old Devise auth
  # before_action :require_login!
  #   helper_method :person_signed_in?, :current_user
  #
  # def user_signed_in?
  #   current_person.present?
  # end
  #
  # def require_login!
  #   return true if authenticate_token
  #   render json: { errors: [ { detail: "Access denied" } ] }, status: 401
  # end
  #
  # def current_user
  #   @_current_user ||= authenticate_token
  # end
  #
  # private
  #   def authenticate_token
  #     authenticate_with_http_token do |token, options|
  #     User.find_by(auth_token: token)
  #     end
  #   end
end