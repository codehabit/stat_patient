class HomeController < ApplicationController
  def index
    @messages = current_user.practitioner.messages
  end
end

