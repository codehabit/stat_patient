class MessagesController < ApplicationController
  def index
    @messages = Message.where(recipient: current_user.practitioner)
  end

  def new
    @message = Message.new
  end

  def create
    Message.create(message_params)
    redirect_to messages_path
  end

  def show
    @message = Message.find(params[:id])
  end

  def edit
    @message = Message.find(params[:id])
  end

  private

  def message_params
    params.require(:message).permit!
  end
end

