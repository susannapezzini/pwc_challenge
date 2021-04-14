class PricesController < ApplicationController
  before_action :fetch_price, only: [:edit, :update]

  def edit
  end

  def update
    if @price.update(price_params)
      if params["fee"]
        @price.fee.active = params["fee"]["active"]
        @price.fee.name = params["fee"]["name"]
        @price.fee.save
      end
      redirect_to subproduct_path(@price.subproduct), notice: 'Price was successfully updated'
    else
      render :edit
    end

  end

  private
    def price_params
      params.require(:price).permit(:fee_id, :subproduct_id, :document, :name, :amount, :category, :tax_category, :tax, :tax_amount, :status, :active)
    end

    def fetch_price
      @price = Price.find(params[:id])
    end
end
