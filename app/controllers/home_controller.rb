class HomeController < ApplicationController
  def index
    @lists = current_user.get_showable_lists
  end
end
