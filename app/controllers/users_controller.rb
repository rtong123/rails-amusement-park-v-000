require 'pry'
class UsersController < ApplicationController
   # before_action :require_login, only: [:show]
   # skip_before_action :require_login, only:[:new, :create]


  def home
    render "layouts/application"
  end


  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @message = params[:message]
    if logged_in?
      @user = User.find_by(id: params[:id])
    else
      redirect_to root_url
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_user_path
    end
  end

  def update
    current_user.update(user_params)
    redirect_to user_path(current_user)
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :nausea, :happiness, :tickets, :height, :admin)
  end

  end
