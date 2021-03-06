class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => :index
  before_filter :admin_or_employer, :except => [:show, :index]
  before_filter :own_account, :only => :destroy

  def index
    @users = User.workers
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin? || current_user.employer? && @user.worker?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def admin_or_employer
    unless current_user.admin? || current_user.employer?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def own_account
    unless current_user == @user
      redirect_to :back, :alert => "Not allowed."
    end
  end

  def secure_params
    params.require(:user).permit(:role, :firstname, :lastname, :profile_picture)
  end

end
