require 'pry'

class BoardGameController < ApplicationController
    get "/board-games" do
        # binding.pry
        if logged_in?
            erb :index
        else
            redirect "/login"
        end
    end

    get "/board-games/new" do
        if logged_in?
            erb :"/board_games/new"
        else
            redirect "/login"
        end
    end

    post "/board-games" do
        if logged_in?
        @bg = BoardGame.new(params)
        current_user.tweets << @bg
        current_user.save
        redirect "/board-games/new"
        else
        redirect "/"
        end
    end

    get "/board-games/:id" do
        if logged_in?
            @bg = BoardGame.find(params[:id])
            erb :"/board_games/show"
        else
            redirect "/login"
        end
    end

    get '/board-games/:id/edit' do
        if logged_in?
          @bg = BoardGame.find_by_id(params[:id])
          if @bg && @bg.user == current_user
            erb :'board_games/edit'
          else
            redirect to '/board-games'
          end
        else
          redirect to '/login'
        end
      end

      #CHECK THIS
      #VVVVVVVVVVVV
    
    patch '/board-games/:id' do
        if logged_in?
          if params[:content] == ""
            redirect to "/board-games/#{params[:id]}/edit"
          else
            @bg = BoardGame.find_by_id(params[:id])
            if @bg && @bg.user == current_user
              if @bg.update(content: params[:content])
                redirect to "/board-games/#{@bg.id}"
              else
                redirect to "/board-games/#{@bg.id}/edit"
              end
            else
              redirect to '/board-games'
            end
          end
        else
          redirect to '/login'
        end
    end
    
      delete '/board-games/:id/delete' do
        if logged_in?
          @bg = BoardGame.find_by_id(params[:id])
          if @bg && @bg.user == current_user
            @bg.delete
          end
          redirect to '/board-games'
        else
          redirect to '/login'
        end
      end
end