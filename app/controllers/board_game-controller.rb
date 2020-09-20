require 'pry'

class BoardGameController < ApplicationController
    get "/boardgames" do
        if logged_in?
          @bg = BoardGame.all
            erb :"/board_games/index"
        else
            redirect "/login"
        end
    end

    get "/boardgames/new" do
        if logged_in?
            erb :"/board_games/new"
        else
            redirect "/login"
        end
    end

    post "/boardgames" do
        if logged_in?
        @bg = BoardGame.new(params)
        current_user.board_games << @bg
        # current_user.save
        redirect "/users/#{current_user.slug}"
        else
        redirect "/"
        end
    end

    get "/boardgames/:id" do
        if logged_in?
            @bg = BoardGame.find(params[:id])
            erb :"/board_games/show"
        else
            redirect "/login"
        end
    end

    get '/boardgames/:id/edit' do
        if logged_in?
          @bg = BoardGame.find_by_id(params[:id])
          if @bg && @bg.user == current_user
            erb :'board_games/edit'
          else
            flash[:alert] = "You are not the owner of that game!"
            redirect to '/boardgames'
          end
        else
          flash[:notice] = "You must be logged in to edit games."
          redirect to '/login'
        end
      end
    
    patch '/boardgames/:id' do
        if logged_in?
          if params[:title] == ""
            flash[:notice] = "Title cannot be blank"
            redirect to "/boardgames/#{params[:id]}/edit"
          else
            @bg = BoardGame.find_by_id(params[:id])
            if @bg && @bg.user == current_user
              if @bg.update(title: params[:title], num_of_players: params[:num_of_players], genre: params[:genre])
                redirect to "/users/#{current_user.slug}"
              else
                redirect to "/boardgames/#{@bg.id}/edit"
              end
            else
              flash[:alert] = "You are not the owner of that game!"
              redirect to '/boardgames'
            end
          end
        else
          flash[:notice] = "You must be logged in to edit games."
          redirect to '/login'
        end
    end
    
      delete '/boardgames/:id/delete' do
        if logged_in?
          @bg = BoardGame.find_by_id(params[:id])
          if @bg && @bg.user == current_user
            @bg.destroy
          end
          flash[:alert] = "You are not the owner of that game!"
          redirect to '/boardgames'
        else
          flash[:notice] = "You must be logged in to delete games."
          redirect to '/login'
        end
      end
end