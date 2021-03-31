class BanksController < ApplicationController
  def new
    @user = User.find(current_user.id)
    @bank = Bank.new
  end

  def create
    @bank = Bank.new(bank_params)
    if @bank.save
      redirect_to root_path, notice: 'Bank was successfully created'
    else
      render :new
    end
  end

  private

  def bank_params
    params.require(:bank).permit(:name, :website, :address, :country, :photo)
  end
end
