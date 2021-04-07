class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :check_if_admin?, only: [:dashboard]

  # No need for Auth
  def home
  end

  # Needs Auth and needs to be admin
  def dashboard
    @banks = Bank.all

    if params[:query].present?
      sql_query = " \
        banks.name @@ :query \
        OR banks.country @@ :query \
      "
      @banks = @banks.where(sql_query, query: "%#{params[:query]}%")
    end
    if @banks.empty?
      flash.now[:alert] = "Sorry, we could not find what you're looking for."
    end
  end

  # Needs Auth
  def overview
    @banks = Bank.all
    @subproducts = Subproduct.all
  end


  # Needs Auth and needs to be admin
  # def settiings
  # end

  private

  def check_if_admin?
    current_user.admin?
  end
end
