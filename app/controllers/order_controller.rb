class OrderController < ApplicationController
    def show

    end

    def create
        @order = Order.new
        @order.user_id = current_user.id
        @order.total_payment = params[:order][:total_payment]
        @order.status = true
        if @order.save 
            @list_seat_id = params[:order][:seat_id]
            @list_seat_id.split(",").each do |seat_id| 
                @seat_order = SeatOrder.new
                @seat_order.screening_id = params[:order][:screening_id]
                @seat_order.seat_id = seat_id
                @seat_order.order_id = @order.id
                if @seat_order.save
                    @success = true
                    @message = "Success! Đặt vé thành công."
                else
                    @success = false
                    @message = "Fail! Đặt vé thất bại."
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

    end
    
   
end
