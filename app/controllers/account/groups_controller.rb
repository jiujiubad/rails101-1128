class Account::GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.groups
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to account_groups_path
      flash[:notice] = "已更新群组"
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to account_groups_path
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
