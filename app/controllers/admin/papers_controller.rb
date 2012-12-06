class Admin::PapersController < Admin::AdminController

  def index
    @papers = Paper.all
  end

end
