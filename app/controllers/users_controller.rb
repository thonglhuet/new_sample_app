class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :admin_user, only: :destroy
  before_action :correct_user, only: [:edit,:update]

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.index.per_page
  end

  def show
    @user = User.find_by id: params[:id]
    not_found if @user.nil?
    @microposts = @user.microposts.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = t ".please_check"
      redirect_to root_url
    else
      render :new
    end
  end

  def following
    @title = t ".following"
    follow
  end

  def followers
    @title = t ".followers"
    follow
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".notice_update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t ".notice_delete"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    load_user
    not_found if @user.nil?
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    @user = User.find_by params[:id]
    not_found if @user.nil?
  end

  def follow
    @user = User.find_by id: params[:id]
    @users = @user.followers.paginate page: params[:page]
    render "show_follow"
  end
end
