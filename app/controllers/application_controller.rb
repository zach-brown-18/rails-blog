class ApplicationController < ActionController::Base
    def authorize
        redirect_to login_path, alert: 'You must be logged in to access this page.' if helpers.current_user.nil?
    end
end
