class WebsitesController < ApplicationController
  before_action :fetch_bank, only: [:index, :create, :destroy]

  def index
    @websites = @bank.websites
    @new_website = Website.new
  end

  def create
    @websites = @bank.websites
    @new_website = Website.new(website_params)
    @new_website.bank = @bank

    if @new_website.save
      redirect_to bank_websites_path(@bank), notice: 'Bank was successfully created'
    else
      render :index
      flash.alert = "Error: Please enter a unique, valid url"
    end
  end

  def destroy
    @website = Website.find(params[:id])
    @website.destroy

    redirect_to bank_websites_path(@bank)
  end
  private
  
  def fetch_bank
    @bank = Bank.find(params[:bank_id])  
  end

  def website_params
    params.require(:website).permit(:url)
  end
end
