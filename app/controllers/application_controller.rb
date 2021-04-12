class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  add_flash_types :info
  def after_sign_in_path_for(resource)
    dashboard_path
  end
end
