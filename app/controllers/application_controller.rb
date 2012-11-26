class ApplicationController < ActionController::Base
  include Nama::I18n

  protect_from_forgery
  include SessionsHelper

  private
    def signed_in_user
      unless signed_in?
        flash[:notice] = "Please sign in."
        redirect_to signin_url
      end
    end
end
