class FeesController < ApplicationController
  before_action :fetch_fee, only: [:edit, :update]
  before_action :fetch_subproduct, only: %i[new create]

  def new
    @fee = Fee.new
    @price = Price.new
    @product = @subproduct.product
  end

  def create
    @fee = Fee.new(fee_params)
    @fee.product = @subproduct.product

    if @fee.save
      redirect_to subproduct_path(@subproduct)
    else
      render :new
    end
    Price.create(amount: params[:price][:amount],
      category: params[:price][:category],
      tax_category: params[:price][:tax_category],
      tax: params[:price][:tax],
      tax_amount: params[:price][:tax_amount],
      status: params[:price][:status],
      fee_id: @fee.id,
      subproduct: @subproduct,
      document: Document.all.sample)
  end

  def edit
  end

  def update
    @fee.active = !@fee.active
    @fee.save
    redirect_back(fallback_location: root_path)
  end

  private
    def fee_params
      params.require(:fee).permit(:subproduct_id, :product_id, :name, :search_name, :price, :active)
    end
    def price_params
      params.require(:fee).permit[:price]
    end

    def fetch_fee
      @fee = Fee.find(params[:id])
    end

    def fetch_subproduct
      @subproduct = Subproduct.find(params[:subproduct_id])
    end
end
