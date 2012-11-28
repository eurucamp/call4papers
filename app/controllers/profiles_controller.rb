class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def edit
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Sukces, milordzie."
      redirect_to profile_path
    else
      flash[:alert] = "Try again."
      render :edit
    end
  end
end
