class ScreenController < ApplicationController
    before_action :authenticate_user!
    layout "app"
    def index
        @films = Film.all
        data_filter = params[:filter]
         if !data_filter.nil?
             @screenings = Screening.where(day_show_film: params[:filter][:date])
             p "di vao day"
         else
            @screenings = Screening.where(day_show_film: Time.now.strftime("%d/%m/%Y"))
         end
        
        respond_to do |format|
            format.html # index.html.erb
            format.js
        end
    end
    def show
        @this_film = Film.friendly.find(params[:film_id])
        @screening = Screening.find(params[:id])
        respond_to do |format|
            format.html # index.html.erb
            format.js
        end
    end
    def payment
        @this_film = Film.friendly.find(params[:film_id])
        @screening = Screening.find(params[:id])
        @foods = Food.all
    end
    
end
