class UsersController < ApplicationController

  def login
  end

  def loginuser
    @user = User.find_by({name: params[:name], email: params[:email], password: params[:password]})
    if @user
      session[:user_id] = @user.id
      redirect_to "/"
    else
      flash[:errors] = ["Invalid login credentials"]
      redirect_to "/"
    end
  end

  def registration
    @user = User.create(name: params[:name], email: params[:email], password: params[:password])
    if @user.errors.any?
      flash[:errors] = ["Email already exists"]
      redirect_to "/users/login"
    else
      session[:user_id] = @user.id
      redirect_to "/"
    end
  end

  def logout
    session.clear
    redirect_to "/users/login"
  end

  def get_contacts
    @all_recipients = User.find(session[:user_id]).all_contacts
  end
end
