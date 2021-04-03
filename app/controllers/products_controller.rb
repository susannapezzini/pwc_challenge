class ProductsController < ApplicationController
  before_action :fetch_product, only: %i[edit update destroy]
  before_action :authorize_admin
  
  def index
    @products = Product.all  
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: 'Product was successfully created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: 'Product was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: "Product removed"
    end
  end

    private
      def product_params
        params.require(:product).permit(:name, :search_name)
      end

      def fetch_product
        @product = Product.find(params[:id])
      end


      def authorize_admin
        return unless !current_user.admin?
        redirect_to root_path, alert: "Sorry, you dont have that permission."
      end

end
