class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy, :like]
    before_action :owned_post, only: [:edit, :update, :destroy]
    
    def index
        if user_signed_in? && current_user.AdminPermissions
            flash[:success] = "Backoffice"
            @users = User.all
            respond_to do |format|
              format.html # index.html.erb
              format.json { render :json => @users }
            end
        else
            if user_signed_in?
                @posts = Post.of_followed_users(current_user.following).order("created_at DESC").page(params[:page]).per(5)
            else
                @posts = Post.all.order('created_at DESC').page(params[:page]).per(5)
            end
        end
    end
    
    def new
        @post = current_user.posts.new
    end
    
    def create
        @post = current_user.posts.create(post_params)
        if @post.save
            if current_user.posts.count == 1
                Follow.create(follower_id: current_user.id, following_id: current_user.id)
            end
            flash[:success] = "Imagem foi carregada com sucesso"    
            redirect_to root_path
        else
            flash.now[:error] = "Carregamento da imagem falhou"
            render :new
        end
    end
    
    def show
    end
    
    def edit
    end
    
    def update
        if @post.update(post_params)
            redirect_to post_path(@post)
            flash[:success] = "Atualização com sucesso"
        else
            flash.now[:error] = "Atualização falhou"
            render :edit
        end
    end
    
    def browse
        @posts = Post.all.order('created_at DESC').page(params[:page]).per(5)
    end
    
    def destroy
        @postuser = @post.user.user_name
        if @post.destroy
            if current_user.AdminPermissions
                redirect_to :back
            else
                redirect_to profile_path(@postuser)
            end
            flash[:success] = 'Publicação apagada'
        end
    end
    
    def like
        if @post.liked_by current_user
            respond_to do |format|
                format.html { redirect_to :back }
                format.js
            end
        end
    end
    
    private
    
    def find_post
        @post = Post.find(params[:id])
    end
    
    def post_params
        params.require(:post).permit(:image, :caption)
    end
    
    def owned_post
        unless current_user == @post.user || current_user.AdminPermissions
            redirect_to root_path
        end
    end
end