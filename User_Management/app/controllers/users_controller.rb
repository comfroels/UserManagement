class UsersController < ApplicationController
  def index
  	@users = User.all
  end
  
  def new
  	if session[:errors]
  		@message = session[:errors]
  	else
  		@message = Array.new
  	end
  end

  def create
  	session.delete(:errors)
  	a = User.new(user_params)
  	if a.save
  		redirect_to action: 'index'
  	else
  		session[:errors] = a.errors.full_messages
  		redirect_to '/users/new'
  	end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if session[:errors]
      @message = session[:errors]
    else
      @message = Array.new
    end
  end

  def update
    session.delete(:errors)
    a = User.find(params[:id])
    if a.update(user_params)
      redirect_to action: 'index'
    else
      session[:errors] = a.errors.full_messages
      redirect_to '/user/' + params[:id].to_s + '/edit'
    end
  end

  def destroy
    a = User.find(params[:id])
    a.destroy
    redirect_to action: 'index'
  end

  private
  def user_params
  	params.require(:user).permit(:first_name,:last_name,:email_address,:password)
  end

end
