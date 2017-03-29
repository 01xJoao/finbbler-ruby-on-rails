class RegistrationsController < Devise::RegistrationsController
    
    def destroy
        @user = User.find(params[:id])
        if @user.destroy
            redirect_to root_url
        end
    end
  
    private
    
    def sign_up_params
        params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end
    
    def account_update_params
        params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :current_password)
    end
end