class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:notice] = "Updated successfully!"
      redirect_to profile_path
    else
      flash[:alert] = "Doh!"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :bio, :website_url, :password,
                                 :password_confirmation, :remember_me, :gender, :mentor)
  end

end
