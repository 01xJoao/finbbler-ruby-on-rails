class RelationshipsController < ApplicationController  
  def follow_user
    @user = User.find_by! user_name: params[:user_name]
    if current_user.follow @user.id
      respond_to do |format|
        format.html { redirect_to root_path } 
        format.js {render inline: "$('#follow-button').text('A Seguir').attr('href', '/<%= @user.user_name%>/unfollow_user').attr('class', 'btn btn-sm unfollow-button').attr('id', 'unfollow-button');"}
      end
    end
  end

  def unfollow_user
    @user = User.find_by! user_name: params[:user_name]
    if current_user.unfollow @user.id
      respond_to do |format|
        format.html { redirect_to root_path } 
        format.js {render inline: "$('#unfollow-button').text('Segue').attr('class', 'btn btn-sm follow-button').attr('href', '/<%= @user.user_name%>/follow_user').attr('id', 'follow-button');"}
      end
    end
  end
end  