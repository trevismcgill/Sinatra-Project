require 'pry'
class UserController < ApplicationController
    
    get "/users" do
        if logged_in?
          @user = User.all
            erb :"/users/index"
        else
            redirect "/login"
        end
    end

    get "/users/most-games" do
        if logged_in?
            @user = User.all.max_by(1) {|user| user.board_games.length}[0]
            redirect "/users/#{@user.username}"
        else
            redirect "/login"
        end
    end

    get '/users/:slug' do
        if logged_in?
            @user = User.find_by_slug(params[:slug])
            erb :'users/show'
        else
            redirect "/login"
        end
    end
    
    get "/signup" do
        if !logged_in?
        erb :"/users/signup"
        else
            flash[:notice] = "You already have an account."
        redirect "/"
      end
    end
        
    post "/signup" do
    @user = User.new(params)
        if @user.save
          session[:user_id] = @user.id
          flash[:notice] = "You are now logged in."
          redirect "/"
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
        redirect "/"
        end
    end
    
    post "/login" do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:notice] = "You are now logged in."
            redirect "/"
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
            flash[:notice] = "You are now logged out."
            redirect "/login"
        else
            redirect "/"
        end
    end

end

#write a custom route so that when a user visits /users/most-games they see the user that has the most game instances associated with them
#HINT: use the max_by method to help you find the user with the most games 