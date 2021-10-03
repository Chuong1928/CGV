module FilmsHelper
    def check_film_sent(start_film_at)
        @curent_time = Time.now.in_time_zone("Asia/Ho_Chi_Minh")
        @start_film_at = start_film_at
        return true if (@curent_time > @start_film_at)
        return false
    end
end
