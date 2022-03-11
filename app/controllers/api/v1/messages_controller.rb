module Api::V1
    class MessagesController < ApplicationController
        def index
            messages = App.find_by_token!(params[:app_id]).chats.find_by_chat_number!(params[:chat_id]).messages
            render json: messages.as_json(only: [:message_number, :created_at, :content])
        end

        def show
            message = App.find_by_token!(
                params[:app_id]).chats.find_by_chat_number!(params[:id]).messages.find_by_message_number!(params[:message_number])
            render json: message.as_json(only: [:message_number, :created_at, :content])
        end

        def create
            chat = App.find_by_token!(params[:app_id]).chats.find_by_chat_number!(params[:chat_id])
            message_number = Rails.cache.increment("reddish_app#{chat.app_id}_chat#{chat.id}_messages_count")
            CreateMessageJob.perform_later chat.id, message_number, params[:content]
            render json: {message_number: message_number}, status: 201
        end

        def destroy
            chat = App.find_by_token!(params[:app_id]).chats.find_by_chat_number!(params[:id])
            DestroyMessageJob.perform_later chat.id
            render status: 204
        end
    end
end