class BanksController < ApplicationController
  before_action :fetch_bank, only: %i[show edit update destroy]
  def index
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

  def show
    @users = @bank.users
    @subproducts = @bank.subproducts
  end

  def new
    @user = current_user
    @bank = Bank.new
    @website = Website.new
  end

  def create
    @bank = Bank.new(bank_params)
    if @bank.save
      redirect_to banks_path, notice: 'Bank was successfully created'
    else
      render :new
    end

    Website.create(url: params[:website][:url], bank_id: @bank.id)
  end

  def edit
    @websites = @bank.websites
  end

  def update
    if current_user.admin?
      @bank.update(bank_params)
      redirect_to bank_path(@bank)
    else
      flash.now[:alert] = "Sorry, you dont have that permission."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    if current_user.admin?
      @bank.destroy
      redirect_to banks_path, notice: "The bank, its subproducts, and its users were deleted successfully."
    else
      flash.now[:alert] = "Sorry, you dont have that permission."
      # redirect_to dashboard_path
      redirect_back(fallback_location: root_path)
    end
  end

  def manage
    @websites = @bank.websites
    @new_website = Website.new
  end

  # def users
  #   if current_user.admin?
  #     @bank.users
  #   else
  #     flash.now[:alert] = "Sorry, you dont have that permission."
  #     # redirect_to dashboard_path
  #     redirect_back(fallback_location: root_path)
  #   end
  # end

  private

  def fetch_bank
    @bank = Bank.find(params[:id])
  end

  def bank_params
    params.require(:bank).permit(:name, :website, :address, :country, :website, files: [])
  end

  def web_params
    params.require(:bank).permit[:website]
  end
end
