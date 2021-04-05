class SubproductsController < ApplicationController
  # before_action :authorize_admin
  before_action :fetch_subproduct, only: %i[edit update destroy show]
  
  def index
    #@product needed for route: /products/:id/subproducts but not route: /subproducts
    if params[:product_id].present?
      fetch_product
      @subproducts = @product.subproducts
    else 
      @subproducts = Subproduct.all
    end
  end

  def new
    @subproduct = Subproduct.new
    
    #if arriving at this route from the /products/:id/subproducts/new, prefill the Product field
    #else if arriving from /subproducts/new
    if params[:product_id].present?
      fetch_product
      @subproduct.product = @product
    end

    if params[:bank_id].present?
      @subproduct.bank = Bank.find(params[:bank_id])
    end
  end

  def create
    @subproduct = Subproduct.new(subproduct_params)
    @product = Product.find(subproduct_params[:product_id])
    @subproduct.bank = Bank.find(subproduct_params[:bank_id])

    if @subproduct.save
      redirect_to bank_path(@subproduct.bank, anchor: 'subproducts'), notice: 'Subproduct was successfully created'
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
      redirect_to bank_path(@subproduct.bank, anchor: 'subproducts'), notice: 'Subproduct was successfully updated'
    else
      render :edit
    end
  end

  def show
    
  end

  def destroy
    @product = @subproduct.product

    if @subproduct.destroy
      redirect_to bank_path(@subproduct.bank, anchor: 'subproducts'), notice: "Subproduct removed"
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
