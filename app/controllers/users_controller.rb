class UsersController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :admin_user,     only: :destroy
  before_filter :correct_user, only: [:edit, :update]
  
  def index
    @users = User.search(params[:search]).paginate(page: params[:page], order: "first_name, last_name")
  end
  
  def show
    @user = User.find(params[:id])
    @events = @user.events.paginate(page: params[:page])
    @event = @user.events.build
    @feed_items = @user.feed.paginate(page: params[:page])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
  
  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    if !current_user?(@user)
      flash[:error] = 'Incorrect user permissions'
      redirect_to(user_path)
    end
  end
end
