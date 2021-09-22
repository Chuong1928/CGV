class AccountController < ApplicationController
    layout "app"
    include FilmsHelper
    def index

    end
     
    def show
        @user = current_user
        if params[:id].nil?
            @account = User.find(current_user.id)
        else 
            @account = User.find(params[:id])
        end
    end
    
    def update
        
    end
end
