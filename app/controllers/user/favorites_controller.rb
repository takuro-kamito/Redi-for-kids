class User::FavoritesController < ApplicationController
  
  def create
  @community = Community.find(params[:community_id])
  favorites = current_user.favorites.new(community_id: @community.id)
  favorites.save
  end 
  
  def destroy
    @community = Community.find(params[:community_id])
    favorites = current_user.favorites.find_by(community_id: @community.id)
    favorites.destroy
  end 
  
  
end
