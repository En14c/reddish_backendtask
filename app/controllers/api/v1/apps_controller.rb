module Api::V1
    class AppsController < ApplicationController
        def index
            apps = App.all()
            render json: apps.as_json(only: [:token, :name, :created_at, :chats_count])
        end

        def show
            app = App.find_by_token!(params[:id])
            render json: app.as_json(only: [:token, :name, :created_at, :chats_count])
        end

        def create
            app = App.create(name: params[:name])
            render json: app.as_json(only: [:token, :name, :created_at, :chats_count]), status: 201
        end

        def update
            app = App.find_by_token!(params[:id])
            UpdateAppJob.perform_later app.id, {name: params[:name]}
            render status: 204
        end

        def destroy
            app = App.find_by_token(!params[:id])
            DestroyAppJob.perform_later app.id
            render status: 204
        end
    end
end