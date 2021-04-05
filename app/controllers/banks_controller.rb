class BanksController < ApplicationController
  before_action :fetch_bank, only: %i[edit update]
  def index
    @banks = Bank.all
  end

  def show
    @bank = Bank.find(params[:id])
  end

  def new
    @user = User.find(current_user.id)
    @bank = Bank.new
  end

  def create
    @bank = Bank.new(bank_params)
    if @bank.save
      redirect_to dashboard_path, notice: 'Bank was successfully created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if current_user.admin?
      @bank.update(bank_params)
      redirect_to dashboard_path
    else
      flash.now[:alert] = "Sorry, you dont have that permission."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def fetch_bank
    @bank = Bank.find(params[:id])
  end

  def bank_params
    params.require(:bank).permit(:name, :website, :address, :country, files: [])
  end
end
