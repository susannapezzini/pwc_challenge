class FeesController < ApplicationController
  before_action :fetch_fee, only: [:edit, :update]

  def new
    @fee = Fee.new
  end

  def create
    @fee = Few.new(fee_params)

    if @fee.save
      # redirect_to product_path(@fee.product.subproduct)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @fee.update(fee_params)
      # redirect_to product_path(@fee.product), notice: 'Fee was successfully updated'
    else
      render :edit
    end
  end

  private
    def fee_params
      params.require(:fee).permit(:product_id, :name, :search_name, :category)
    end

    def fetch_fee
      @fee = Fee.find(params[:id])
    end
end
