class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Updated successfully!"
      redirect_to profile_path
    else
      flash[:alert] = "Doh!"
      render :edit
    end
  end
end
