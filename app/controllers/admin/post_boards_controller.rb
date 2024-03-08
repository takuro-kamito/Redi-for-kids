class Admin::PostBoardsController < ApplicationController
  def index
    @community = Community.find(params[:community_id])
    @post_boards = @community.post_boards
    @users = User.all
  end

  def destroy
    @post_board = PostBoard.find(params[:id])
    @community = @post_board.community
    @post_board.destroy
    flash[:notice] = "削除しました。"
    redirect_to admin_community_post_board_path(community_id: @community.id)
  end
end
