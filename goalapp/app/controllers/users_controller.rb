class UsersController < ApplicationController
  def index 
    @users = User.all 
    render :index
  end 
  
  def create 
    user = User.create(user_params)
    
    if user.save 
      login!(user)
      redirect_to user_url(user)
    else 
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_url
    end 
  end 
  
  def show 
    @user = User.find(params[:id])
    render :show
  end
  
  def edit 
    render :edit 
  end 
  
  def update 
    @user = User.find(params[:id])
    if @user.update(user_params)
      @user.save
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to edit_user_url
    end 
  end 
  
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to new_user_url
  end
  
  private 
  def user_params
    params.require(:users).permit(:username, :password)
  end 
end