class MessagesController < ApplicationController

  def new
  end

  def create
    if message.valid?
      MessageMailer.new_message_email(message).deliver_now
      redirect_to contact_path, notice: "Your message has been sent."
    else
      render :new
    end
  end

  private

  def message
    @_message ||= Message.new(message_params)
  end
  helper_method :message

  def message_params
    (params[:message] || ActionController::Parameters.new({})).permit(
      :name, :email, :content
    )
  end

end
