class UsersController < ApplicationController

  def new

  	@user  = User.new
  	@title = "Sign Up"

  end

  def show

  	@user  = User.find(params[:id])
  	@title = @user.name

  end

  def create

  	@user = User.new(params[:user])

  	if @user.save

  		redirect_to user_path(@user)
      flash[:success] = "Welcome to the Sample App!"

	  else

	  	@title = "Sign Up"
      @user.password = ""
      @user.password_confirmation = ""
	  	render 'new'

	  end
  end
end
