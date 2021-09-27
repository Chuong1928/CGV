class OrderController < ApplicationController
  layout "app"
    def show
        @user = User.friendly.find(current_user.id)
        @order = Order.find(params[:id])
        @pay_food = 0;
        @order.foodorders.each do |food_order|
              @pay_food += (food_order.quantity * food_order.food.price)
          end
        @list_seat_of_order = []
        @order.seat_orders.each do |seat_order|
          @list_seat_of_order << seat_order.seat.id
        end
    end

    def create
        
        # @order = Order.new
        # @order.user_id = current_user.id
        # @order.total_payment = params[:order][:total_payment]
        @order = current_user.orders.build(order_params)
        @order.status = true
        @seatorder_ids = Screening.find(params[:order][:screening_id]).seat_orders.pluck(:seat_id)
        @list_seat_id = params[:order][:seat_id]
        @list_seat_id.split(",").each do |seat_id|
              if !(@seatorder_ids.include?(seat_id.to_i))
                if @order.save 
                    @seat_order = @order.seat_orders.build(seat_order_params)
                    #@seat_order.screening_id = params[:order][:screening_id]
                    @seat_order.seat_id = seat_id
                    @seat_order.status = true
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
           
           
           if  @list_food_id = params[:order][:list_food_id]
                if @order.save
                  @list_food_id.each do |index|
                    @food_order = @order.foodorders.build(food_id: index[1][:id], quantity: index[1][:quantity])
                        if @food_order.save 
                              @success = true
                              @message = "Success! Đặt vé thành công."
                        
                        else
                              @success = false
                              @message = "Fail! Đặt vé thất bại! lưu foododer không thành công."
                        end
                  end
                  
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

    def cancel_order
      @order_id = params[:order][:order_id]
      
      if current_user.orders.find(@order_id).seat_orders.destroy_all && current_user.orders.find(@order_id).update(status: false)

        respond_to do |format|
          format.json { render :json => { :message => "Hủy đặt vé thành công" }.to_json }
        end
      else
        respond_to do |format|
          format.json { render :json => { :message => "Hủy đặt vé thất bại" }.to_json }
        end
      end
    end  
    
   private
    # Use callbacks to share common setup or constraints between actions.
    # def set_user
    #   @user = User.find(params[:id])
    # end

   

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:total_payment)
    end

    def seat_order_params
      params.require(:order).permit(:screening_id)
    end
    
end
