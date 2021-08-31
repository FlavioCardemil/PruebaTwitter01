class ApplicationController < ActionController::Base
    before_action :banned?
    before_action :devise_signup, if: :devise_controller?

    protected

    def banned?
        if current_user.present? && current_user.banned?
            sign_out current_user
            flash[:error] = 'Estás baneado'
            root_path
        end
    end

    def devise_signup
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :photo])
    end
end
