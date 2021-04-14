class GroupsController < ApplicationController
  before_action :fetch_group, only: %i[edit update]
  before_action :fetch_subproduct, only: %i[new create]

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(group_params)
    @subproduct.group = @group
    if @subproduct.save
      redirect_to edit_subproduct_path(@subproduct)
    else
      render "subproducts/edit"
    end

  end

  def edit
  end

  def update
    if current_user.admin?
      @group.update(group_params)
      redirect_to products_path
    else
      flash.now[:alert] = "Sorry, you dont have that permission."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def fetch_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end

  def fetch_subproduct
    @subproduct = Subproduct.find(params[:subproduct_id])
  end
end
