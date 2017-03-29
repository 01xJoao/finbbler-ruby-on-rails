class ClothesController < ApplicationController
    before_action :find_post
    
    def create
        @clothe = @post.clothes.new(clothe_params)
        
        if @clothe.save
            flash[:success] = "Peça de roupa adicionada."   
            redirect_to :back
        else
            flash[:error] = "Para adicionar uma peça de roupa tem que preencher todos os campos."  
            redirect_to :back
        end
    end
    
    def destroy
        @clothe = @post.clothes.find(params[:id])
        if @clothe.destroy
            redirect_to :back
        end
        #respond_to do |format|
        #    format.js {render inline: "$('#tablepop).closest('tr').remove();"} 
        #    format.html {redirect_to root_path}
        #end
    end
    
    private 
    
    def clothe_params
        params.require(:clothe).permit(:clothe_name, :price, :store_name, :store_link)
    end
    
    def find_post
        @post = Post.find(params[:post_id])
    end
end
