class MessagesController < ApplicationController
  def index
    @messages = Message.where(recipient: current_user.practitioner)
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.valid?
      @message.save
      PractitionerMailer.notification_email(@message).deliver
      redirect_to messages_path
    else
      render action: :new
    end
  end

  def show
    @message = Message.find(params[:id])
    if @message.recipient.user != current_user
      redirect_to messages_path
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  private

  def message_params
    params.require(:message).permit!
  end
end

