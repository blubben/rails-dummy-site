class UsersController < ApplicationController
  def index
    if(signed_in?)
      redirect_to current_user
    else
      redirect_to '/signin'
    end

  end

  def show
    if(signed_in?)
      @user = User.find(params[:id])
    else
      redirect_to '/signin'
    end
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :website)
    end
end
