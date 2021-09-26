class AccountController < ApplicationController
    layout "app"
    include FilmsHelper
    def index

    end
     
    def show
        @user = current_user
        if params[:id].nil?
            @account = User.friendly.find(current_user.id)
        else 
            @account = User.friendly.find(params[:id])
        end
        p @account
    end
    
    def update
        
    end
end
