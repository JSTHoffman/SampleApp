class SessionsController < ApplicationController

  def new

  	@title = "Sign In"

  end

  def create

  	user = User.authenticate(params[:session][:email],
  													 params[:session][:password])
  	
  	if user.nil?

  		flash.now[:error] = "Invalid email/password combination."
  		@title = "Sign In"
  		render 'new'

  	else

  		# sign in user and redirect to user's show page

  	end
  end

  def destroy
  end

end
