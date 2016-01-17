class MessageMailer < ApplicationMailer

  def new_message_email(message)
    @message = message

    mail subject: "Message from #{message.name}"
  end

end
