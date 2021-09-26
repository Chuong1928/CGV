class UserController < ApplicationController
    skip_before_action :verify_authenticity_token, :only => [:update, :edit]
    def index

        end
    def show

        end
    
    def update
            @user = User.friendly.find(params[:id])
            if @user.update(user_params)
                flash[:notice] = "Cập nhật thành công"
                redirect_to account_path
            else
                  
                flash[:alert] = @user.errors.full_messages.join(". ")
                redirect_to account_path
            end
           
        end

    private
    def user_params
        params.require(:user).permit(:name, :identificate, :birthday, :address, :phone, :phone, :gender, :city)
    end
end
