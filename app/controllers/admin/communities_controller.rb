class Admin::CommunitiesController < ApplicationController

  def index
    @community = Community.new
    @communities = Community.all
  end

  def create
    @communities = Community.all
    @community = Community.new(community_params)
    @community.admin_id = current_admin.id
    if @community.save
      #コミュニティの新規登録が成功開いた場合の処理
      flash[:notice] = "登録に成功しました。"
      redirect_to admin_communities_path(@community)
    else
      #コミュニティが失敗した場合の処理
      flash.now[:alert] = "登録に失敗しました。"
      render :index
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
    if @community.update(community_params)
      # コミュニティの更新が成功した場合の処理
      flash[:notice] = "更新に成功しました。"
      redirect_to admin_communities_path
    else
      # コミュニティの更新が失敗した場合の処理
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

   def destroy
    @community = Community.find(params[:id])
    @community.destroy
    # コミュニティの削除が成功した場合の処理
    flash[:notice] = "削除に成功しました。"
    redirect_to admin_communities_path
   end

  private

  def community_params
    params.require(:community).permit(:name, :explanation, :admin_id)
  end
end
