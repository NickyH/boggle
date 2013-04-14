class UsersController < ApplicationController
  before_filter :authenticate
  def index
    @users = User.order(:username)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.create(params[:user])
  end
  def show
  end
  def new_player
    @user = User.new
  end
  def edit
    @user = @auth
  end
  def update
    @auth.update_attributes(params[:user])
  end
end
