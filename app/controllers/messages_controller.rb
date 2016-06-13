class MessagesController < ApplicationController
  def index
    if params[:email]
      @mailbox = Mailbox.new(params[:email])
      render json: @mailbox.to_json
    else
      head :unprocessable_entity
    end
  end
end
