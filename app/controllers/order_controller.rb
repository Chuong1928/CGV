class OrderController < ApplicationController
  layout "app"
    def show
        @order = Order.find(params[:id])
        @list_seat_of_order = []
        @order.seat_orders.each do |seat_order|
          @list_seat_of_order << seat_order.seat.id
        end
    end

    def create
        @order = Order.new
        @order.user_id = current_user.id
        @order.total_payment = params[:order][:total_payment]
        @order.status = true
        @seatorder_ids = Screening.find(params[:order][:screening_id]).seat_orders.pluck(:seat_id)
        
        @list_seat_id = params[:order][:seat_id]
        @list_seat_id.split(",").each do |seat_id|
              if !(@seatorder_ids.include?(seat_id.to_i))
                if @order.save 
                    @seat_order = SeatOrder.new
                    @seat_order.screening_id = params[:order][:screening_id]
                    @seat_order.seat_id = seat_id
                    @seat_order.order_id = @order.id
                      if @seat_order.save 
                          @success = true
                          @message = "Success! Đặt vé thành công."
                      else
                          @success = false
                          @message = "Fail! Đặt vé thất bại! lưu seatoder không thành công."
                       end
                 else
                   @success = false
                   @message = "Fail! Đặt vé thất bại!- lỗi khi lưu order."
                 end
              else
                @success = false
                @message = "Fail! Đặt vé thất bại!- lỗi khi lưu order - trùng seat_id."
              end
            end
            respond_to do |format|
                format.html { 
                  if @success
                    flash[:success] = @message
                    redirect_to @order
                    return true
                  else 
                    flash[:error] = @message
                  end
                }
                format.json { render :json => { :success => @success, :message => @message }.to_json }
              end 
    end

    def sent_you_ticket
      @ticket_id = params[:mail][:ticket_id]
      
      if SentTicketMailer.sent_you_ticket(current_user, @ticket_id ).deliver_now
        respond_to do |format|
          format.json { render :json => { :message => "Gửi mail thành công" }.to_json }
        end
      else
        respond_to do |format|
          format.json { render :json => { :message => "Gửi mail thất bại" }.to_json }
        end
      end
    end
    
   
end
