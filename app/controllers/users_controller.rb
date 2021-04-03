class UsersController < ApplicationController
  before_action :authorize_admin
  before_action :fetch_bank
  before_action :fetch_user, only: %i[edit update]
  def index
    @users = @bank.users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.bank = @bank
    
    if @user.save
      redirect_to bank_users_path(@bank)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to bank_users_path(@bank)
    else
      render :edit
    end
  end
  
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
        redirect_to root_url, notice: "User deleted."
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end

    def fetch_bank
      @bank = Bank.find(params[:bank_id])
    end

    def fetch_user
      @user = User.find(params[:id])
    end

    def authorize_admin
      return unless !current_user.admin?
      redirect_to root_path, alert: "Sorry, you dont have that permission."
    end
end
