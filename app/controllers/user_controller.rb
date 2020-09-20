require 'pry'
class UserController < ApplicationController
    
    get "/boardgames" do
        # binding.pry
        if logged_in?
          @bg = BoardGame.all
            erb :"/board_games/index"
        else
            redirect "/login"
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end
    
    get "/signup" do
        if !logged_in?
        erb :"/users/signup"
        else
            flash[:notice] = "You already have an account."
        redirect "/home"
      end
    end
        
    post "/signup" do
    @user = User.new(params)
        if @user.save
          session[:user_id] = @user.id
          redirect "/home"
        else
            # binding.pry
            flash[:errors] = @user.errors.full_messages
          redirect "/signup"
    end   
    end
    
    get "/login" do
        if !logged_in?
        erb :"/users/login"
        else
            flash[:notice] = "You are already logged in."
        redirect "/home"
        end
    end
    
    post "/login" do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/home"
        else
            if !@user
                flash[:notice] = "There is no account registered under that email address."
                redirect to "/login"
            else
                flash[:notice] = "Password is incorrect"
                redirect "/login"
            end
        end
    end

    get "/logout" do
        if logged_in?
            session.clear
            redirect "/login"
        else
            redirect "/"
        end
    end

end