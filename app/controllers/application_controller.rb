class ApplicationController < ActionController::Base
  include Nama::I18n

  protect_from_forgery
  include SessionsHelper
end
