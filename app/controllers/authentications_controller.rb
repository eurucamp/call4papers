class AuthenticationsController < ApplicationController
  skip_before_filter :authenticate
  layout 'welcome'

  rescue_from ActionController::RedirectBackError do |exception|
    redirect_to profile_url
  end

  def index
    @proposal_counts = Proposal.for_open_call.group(:call).count
    @user_count   = User.count
  end

  def create
    omniauth = request.env['omniauth.auth']
    provider, uid  = omniauth.values_at('provider', 'uid')
    authentication = Authentication.find_by(provider: provider, uid: uid)

    if authentication
      flash[:notice] = 'Signed in successfully'
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.find_or_create_by(provider: provider, uid: uid)
      current_user.apply_provider_handle(omniauth)
      current_user.save
      flash[:notice] = 'Connected successfully'
      redirect_to :back
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = 'Signed in successfully'
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except(:extra)
        redirect_to new_user_registration_url
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy

    flash[:notice] = 'Successfully disconnected provider'
    redirect_to authentications_url
  end
end
