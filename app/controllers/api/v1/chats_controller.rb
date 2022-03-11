module Api::V1
    class ChatsController < ApplicationController
        def index
            chats = App.find_by_token!(params[:app_id]).chats
            render json: chats.as_json(only: [:chat_number, :messages_count, :created_at])
        end

        def show
            chat = App.find_by_token!(params[:app_id]).chats.find_by_chat_number!(params[:id])
            render json: chat.as_json(only: [:chat_number, :messages_count, :created_at])
        end

        def create
            app = App.find_by_token!(params[:app_id])
            chat_number = Rails.cache.increment("reddish_app_#{app.id}_chats_count")
            CreateNewChatsJob.perform_later app.id, chat_number
            render json: {chat_number: chat_number}, status: 201
        end

        def destroy
            chat = App.find_by_token!(params[:app_id]).chats.find_by_chat_number!(params[:id])
            DestroyChatsJob.perform_later chat.id
            render status: 204
        end

        def search
            messages = Message.search(params[:q]).records
            render json: messages.as_json(only: [:message_number, :created_at])
        end
    end
end