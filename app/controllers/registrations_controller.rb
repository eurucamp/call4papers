class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate
  layout 'welcome'

  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  private
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end

  def resource_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
