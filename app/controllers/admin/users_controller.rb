class Admin::UsersController < Admin::AdminController
  def index
    @users = User.order('created_at DESC').all
  end
end
