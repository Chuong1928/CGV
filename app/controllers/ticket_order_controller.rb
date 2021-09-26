class TicketOrderController < ApplicationController
    before_action :authenticate_user!
    layout "app"
    def index
        @this_film = Film.friendly.find(params[:film_id])
        data_filter = params[:search]
         if !data_filter.nil?
             @screenings = @this_film.screenings.where(day_show_film: params[:search][:date])
             p "di vao day"
         else
            @screenings = @this_film.screenings.where(day_show_film: Time.now.strftime("%d/%m/%Y"))
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
    
end
