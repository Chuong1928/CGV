module FilmsHelper
    def check_film_sent(start_film_at)
        @curent_time = (Time.now.strftime("%d%m%Y%H%M"))
        @start_film_at = start_film_at.strftime("%d%m%Y%H%M")
        return true if ((@curent_time.to_i) - (@start_film_at.to_i) > 0)
        return false
    end
end
