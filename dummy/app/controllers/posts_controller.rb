class PostsController < ApplicationController
  def new
    @user = current_user
    @post = current_user.posts.new
  end

  def create
    @user = current_user
    @post = current_user.posts.create(params[:post].permit(:title, :text))
    redirect_to user_post_path(@user, @post)
  end

  def update
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    if(logged_in?(@user) && @post.update(params[:post].permit(:title, :text)))
      redirect_to user_post_path(@user, @post)
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    if(current_user!=@user)
      redirect_to user_post_path(@user, @post)
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.all
  end
end
