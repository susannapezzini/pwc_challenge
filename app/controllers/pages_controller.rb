class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :check_if_admin?, only: [:dashboard]

  # No need for Auth
  def home
  end

  # Needs Auth and needs to be admin
  def dashboard
  end

  # Needs Auth
  def overview
  end


  # Needs Auth and needs to be admin
  # def settiings
  # end

  private

  def check_if_admin?
    current_user.admin?
  end
end
