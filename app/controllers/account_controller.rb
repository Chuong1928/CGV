class AccountController < ApplicationController
    layout "app"
    include FilmsHelper
    def index
    end
     
    def show
        @user = current_user
    end
end
