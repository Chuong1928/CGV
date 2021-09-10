class TicketOrderController < ApplicationController
    layout "app"
    def index
        @this_film = Film.find(params[:film_id])
    end
end
