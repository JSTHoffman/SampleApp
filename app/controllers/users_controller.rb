class UsersController < ApplicationController
  before_filter :authenticate,   :only => [:edit, :update, :index, :destroy]
  before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user,     :only => [:destroy]
  before_filter :signed_in_user, :only => [:new, :create]

  def index
    @users = User.paginate(:page => params[:page])
    @title = "All Users"
  end

  def show
    @user  = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page], :per_page => 10)
    @title = @user.name
  end

  def new
  	@user  = User.new
  	@title = "Sign Up"
  end

  def create
  	@user = User.new(params[:user])

  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
	  	@title = "Sign Up"
      @user.password = ""
      @user.password_confirmation = ""
	  	render 'new'

	  end
  end

  def edit
    @title = "Edit User"
  end

  def update

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated."
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'

    end
  end

  def destroy
    @user = User.find(params[:id])

    if current_user == @user
      flash[:notice] = "You cannot destroy yourself."
      redirect_to users_path
    else
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_path

    end
  end

  ########################################################################

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def signed_in_user
      redirect_to(root_path) if signed_in?
    end
end
