class GroupsController < ApplicationController
  before_action :fetch_group, only: %i[edit update]
  def new
  end

  def create
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
end
