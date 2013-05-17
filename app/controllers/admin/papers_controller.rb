class Admin::PapersController < Admin::AdminController
  def index
    @papers = Paper.order('selected DESC, track ASC, time_slot ASC, created_at DESC').all
  end
end
