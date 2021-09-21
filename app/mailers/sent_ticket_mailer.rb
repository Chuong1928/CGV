class SentTicketMailer < ApplicationMailer
    def sent_you_ticket(user,order_id)
        @user = user
        @this_order = Order.find(order_id)
        @list_seat_of_order = []
        @this_order.seat_orders.each do |seat_order|
          @list_seat_of_order << seat_order.seat.id
        end
        mail to: user.email, subject: "Your Ticket"
    end
end
