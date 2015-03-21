class Admin::CallsController < Admin::AdminController
  def index
    @calls = Call.all
  end
end
