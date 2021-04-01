class WebsitesController < ApplicationController

  def manage
    @bank = Bank.find(params[:id])
    @new_website = Website.new
    @websites = @bank.websites
  end

  def create
    @website = Website.new(website_params)
    @bank = Bank.find(params[:bank_id])
  
    if @website.save
      redirect_to manage_websites_path(@bank), notice: 'Bank was successfully created'
    else
      @websites = @bank.websites
      render "banks/manage"
    end
  end

  private
  
  def website_params
    params.require(:website).permit(:url)
  end
end
