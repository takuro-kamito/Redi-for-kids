class Admin::PostBoardsController < ApplicationController
  def index
    @community = Community.find(params[:community_id])
    @post_boards = @community.post_boards
    @users = User.all
  end

  def destroy
    @post_board = PostBoard.find(params[:id])
    @community = @post_board.community
  if @post_board
    @post_board.destroy
    flash[:notice] = "削除しました。"
  else
    flash[:alert] = "削除できませんでした。"
  end
  redirect_to admin_community_post_boards_path(community_id: @community.id)
  end
end
