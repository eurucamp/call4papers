class HomeController < ApplicationController
  def show
    @open_calls = Call.open
  end
end
