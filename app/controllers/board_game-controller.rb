require 'pry'

class BoardGameController < ApplicationController
    get "/boardgames" do
        # binding.pry
        if logged_in?
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
            redirect to '/boardgames'
          end
        else
          redirect to '/login'
        end
      end

      #CHECK THIS
      #VVVVVVVVVVVV
    
    patch '/boardgames/:id' do
        if logged_in?
          if params[:title] == ""
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
              redirect to '/boardgames'
            end
          end
        else
          redirect to '/login'
        end
    end
    
      delete '/boardgames/:id/delete' do
        if logged_in?
          @bg = BoardGame.find_by_id(params[:id])
          if @bg && @bg.user == current_user
            @bg.destroy
          end
          redirect to '/boardgames'
        else
          redirect to '/login'
        end
      end
end