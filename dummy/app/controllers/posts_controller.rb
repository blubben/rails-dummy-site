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

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    if(logged_in?(@user))
      @post.destroy
    end
    redirect_to user_posts_path
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
  before_filter :disable_xss_protection

  protected
  def disable_xss_protection
    # Disabling this is probably not a good idea,
    # but the header causes Chrome to choke when being
    # redirected back after a submit and the page contains an iframe.
    response.headers['X-XSS-Protection'] = "0"
  end
end
