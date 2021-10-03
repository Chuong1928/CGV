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
        @status_login = user_signed_in?
        @mine = (current_user.present? && @user == current_user) || false
        @screening_part = film_path(@this_film) << screen_path(@screening)
        respond_to do |format|
            format.html # index.html.erb
            format.js
            format.json { render :json => {
                screen_data:  @screening.as_json(
                    only: [:film_id, :room_id],
                    methods: [:id, :film_name, :room_name, :seat_slot, :format_start_film_at]
                ),
                status_login: @status_login,
                mine: @mine,
                screen_part: @screening_part
            }}
        end
    end
    def payment
        @this_film = Film.friendly.find(params[:film_id])
        @screening = Screening.find(params[:id])
        @foods = Food.all
    end
    
end
