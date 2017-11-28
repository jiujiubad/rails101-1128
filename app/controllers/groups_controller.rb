class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :create, :destroy]
  before_action :find_group, only: [:show, :edit, :update, :destroy, :join, :quit]
  before_action :check_permission, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
      flash[:notice] = "已更新群组"
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  def join
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
    end
    redirect_to :back
  end

  def quit
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
    end
    redirect_to :back
  end

  private

  def find_group
    @group = Group.find(params[:id])
  end

  def check_permission
    if current_user != @group.user
      redirect_to root_path
      flash[:alert] = "权限不足"
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
