class MessagesController < ApplicationController
  def inbox
    if !session[:user_id]
      redirect_to "/users/login"
    else
      @messages_for_user = User.find(session[:user_id]).recieved_messages
      render "inbox"
    end
  end

  def outbox
    @messages_from_user = User.find(session[:user_id]).sent_messages
  end

  def get_create
    @all_users = User.all
  end

  def post_message
    @message = Message.create(title: params[:title], content: params[:content], sender_id: session[:user_id], recipient_id: params[:recipient])
    redirect_to "/"
  end

end
