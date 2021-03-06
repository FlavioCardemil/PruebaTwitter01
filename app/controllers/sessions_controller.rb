class SessionsController < Devise::SessionsController
    protected

    def after_sign_in_path_for(resource)
        if resource.is_a?(User) && resource.banned?
            flash[:alert] = "Esta cuenta ha sido baneada"
            sign_out resource
            root_path
        else
            super 
        end
    end
end
