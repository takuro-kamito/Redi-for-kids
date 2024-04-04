class Admin::CommunitiesController < ApplicationController

  def index
    @community = Community.new
    @communities = Community.all.order('created_at DESC').page(params[:page]).per(4)
  end
  

  def create
    @communities = Community.all # @communitiesに値をセットする
    @community = Community.new(community_params)
     if @community.save
    redirect_to admin_communities_path(@community)
　  else
    flash[:notice] = @community.errors.full_messages.first
    redirect_to request.referer
     end
  end

  def show
    @community = Community.find(params[:id])
  end

  def edit
    @community = Community.find(params[:id])
  end

  def update
    @community = Community.find(params[:id])
    @community.update(community_params)
    redirect_to admin_communities_path
  end

   def destroy
    @community = Community.find(params[:id])
    @community.destroy
    redirect_to admin_communities_path
   end

  private

  def community_params
    params.require(:community).permit(:name, :explanation, :admin_id, :genre_id)
  end
end