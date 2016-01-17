class MessageMailer < ApplicationMailer

  def new_message_email(message)
    @message = message

    mail from: @message.email, subject: "Message from #{message.name}"
  end

end
