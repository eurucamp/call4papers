class Admin::PapersController < Admin::AdminController
  def index
    @papers = Paper.order('created_at DESC').all
  end
end
