class ApplicationController < ActionController::Base
    before_action :devise_signup, if: :devise_controller?

    protected

    def devise_signup
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :photo])
        devise_parameter_sanitizer.permit(:update, keys: [:name, :photo])
    end
end
