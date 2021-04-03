class SubproductsController < ApplicationController
  before_action :fetch_subproduct, only: %i[edit update destroy]
  before_action :fetch_product
  before_action :authorize_admin

  def index
    @subproducts = @product.subproducts
    @subproducts = Subproduct.all  
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
    @subproduct.product = @product
    @subproduct.bank = Bank.find(subproduct_params[:bank_id])
    
    if @subproduct.update(subproduct_params)
      redirect_to product_subproducts_path(@product), notice: 'Subproduct was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    if @subproduct.destroy
      redirect_to product_subproducts_path(@product), notice: "Subproduct removed"
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
