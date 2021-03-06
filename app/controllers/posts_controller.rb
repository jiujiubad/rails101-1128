class PostsController < ApplicationController



  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @group = Group.find(params[:group_id])
    @post.group = @group
    @post.user = current_user
    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
