class ApplicationController < ActionController::Base
  include Nama::I18n

  protect_from_forgery

  before_filter :setup_user

  private
    def setup_user
      token = cookies[:remember_token]
      if token
        User.current = User.find_by_remember_token(token)
      end
    end

    def signed_in_user
      unless User.signed_in?
        flash[:notice] = "Please sign in."
        redirect_to signin_url
        return false
      end
      return true
    end

    def authorize_admin
      return false unless signed_in_user

      unless User.current.is_admin?
        render 'static_pages/error'
        return false
      end
    end

    def authorize_organizer
      return false unless signed_in_user

      unless User.current.is_organizer?
        render 'static_pages/error'
        return false
      end
    end
end
