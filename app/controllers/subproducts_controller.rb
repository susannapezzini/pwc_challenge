class SubproductsController < ApplicationController
  before_action :authorize_admin
  before_action :fetch_product, only: %i[index new create]
  before_action :fetch_subproduct, only: %i[edit update destroy]
  
  def index
    @subproducts = @product.subproducts
  end

  def new
    @subproduct = Subproduct.new
    @subproduct.product = @product
  end

  def create
    @subproduct = Subproduct.new(subproduct_params)
    @subproduct.product = @product
    @subproduct.bank = Bank.find(subproduct_params[:bank_id])

    if @subproduct.save
      redirect_to product_subproducts_path(@product), notice: 'Subproduct was successfully created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    #@subproduct.product = Bank.find(subproduct_params[:bank_id])
    @subproduct.bank = Bank.find(subproduct_params[:bank_id])

    if @subproduct.update(subproduct_params)
      redirect_to product_subproducts_path(@subproduct.product), notice: 'Subproduct was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @product = @subproduct.product

    if @subproduct.destroy
      redirect_to product_subproducts_path(@product, @subproduct), notice: "Subproduct removed"
    end
  end

    private
      def subproduct_params
        params.require(:subproduct).permit(:name, :product_id, :bank_id)
      end

      def fetch_subproduct
        @subproduct = Subproduct.find(params[:id])
      end

      def fetch_product
        @product = Product.find(params[:product_id])
      end

      def authorize_admin
        return unless !current_user.admin?
        redirect_to root_path, alert: "Sorry, you dont have that permission."
      end

end
