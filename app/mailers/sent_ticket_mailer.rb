class SentTicketMailer < ApplicationMailer
    def sent_you_ticket(user,order_id)
        @user = user
        @this_order = Order.find(order_id)
        @list_seat_of_order = []
        @pay_food = 0;
        @this_order.foodorders.each do |food_order|
              @pay_food += (food_order.quantity * food_order.food.price)
          end
        @this_order.seat_orders.each do |seat_order|
          @list_seat_of_order << seat_order.seat.id
        end
        mail to: user.email, subject: "Your Ticket"
    end
end
