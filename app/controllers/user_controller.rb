require 'pry'
class UserController < ApplicationController
    
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/#PROPER VIEW GOES HERE'
    end
    
    get "/signup" do
        if !logged_in?
        erb :"/users/signup"
        else
        redirect "/PROPER ROUTE"
      end
    end
        
    post "/signup" do
    @user = User.new(params)
        if @user.save
          session[:user_id] = @user.id
          redirect "/PROPER ROUTE"
        else
          redirect "/signup"
    end   
    end
    
    get "/login" do
        if !logged_in?
        erb :"/users/login"
        else
        redirect "/PROPER ROUTE"
        end
    end
    
    post "/login" do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/PROPER ROUTE"
        else
            redirect to "/PROPER ROUTE"
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