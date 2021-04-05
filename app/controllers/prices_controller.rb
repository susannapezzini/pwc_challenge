class PricesController < ApplicationController

  def edit
    @price = Price.find(params[:id])
  end

  def update
    @price = Price.find(params[:id])

    if @price.update(price_params)
      redirect_to subproduct_path(@price.subproduct), notice: 'Price was successfully updated'
    else
      render :edit
    end
  end

  private
    def price_params
      params.require(:price).permit(:fee_id, :subproduct_id, :document, :name, :amount, :category, :tax_category, :tax, :tax_amount, :status)
    end

end
