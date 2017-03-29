class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :owned_profile, only: [:edit, :update]
  
  def show
    @posts = User.find_by(user_name: params[:user_name]).posts.order('created_at DESC')
  end
  
  def edit
  end
  
  def update
    if @user.update(profile_params)
      flash[:success] = 'O teu perfil foi atualizado.'
      redirect_to profile_path(@user.user_name)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end
  
  def search
    @query = params[:query]
    @user = User.where("user_name LIKE ?", @query)
    if @user.blank?
      flash[:error] = 'Não existe nenhum utilizador com o nome ' + @query
      redirect_to :back
    else
      @user = @user.map{|u| u.user_name}
      redirect_to profile_path(@user)
    end
  end
  
  private
  
  def profile_params
    params.require(:user).permit(:avatar, :bio)
  end
  
  def owned_profile
    unless current_user == @user
      flash[:alert] = "Este não é o teu perfil."
      redirect_to root_path
    end
  end
  
  def set_user
    @user = User.find_by(user_name: params[:user_name])
  end
end
