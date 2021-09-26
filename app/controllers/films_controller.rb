class FilmsController < ApplicationController
    layout "app"
    def index
        @search = Film.friendly.search(params[:q])
        @films = @search.result
        respond_to do |format|
            format.html # index.html.erb
            
        end
    end
    def show
        @films = Film.all
        @film = Film.friendly.find(params[:id])
        data_filter = params[:search]
         if !data_filter.nil?
             @screenings = @film.screenings.where(day_show_film: params[:search][:date])
             p "di vao day"
         else
            @screenings = @film.screenings.where(day_show_film: Time.now.strftime("%d/%m/%Y"))
         end
        
        respond_to do |format|
            format.html # index.html.erb
            format.js
        end
       
    end
end
