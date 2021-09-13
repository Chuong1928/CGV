class FilmsController < ApplicationController
    layout "app"
    def index
        @search = Film.search(params[:q])
        @films = @search.result
        respond_to do |format|
            format.html # index.html.erb
            
        end
    end
    def show
        @film = Film.all.find(params[:id])
        respond_to do |format|
            format.html # index.html.erb
            
        end
    end
end
