class Admin::PostBoardsController < ApplicationController
  def index
    @community = Community.find(params[:community_id])
    @post_boards = @community.post_boards.order('created_at DESC').page(params[:page]).per(3)
    @users = User.all
  end

  def destroy
    @post_board = PostBoard.find(params[:id])
    @community = @post_board.community
    @post_board.destroy
  redirect_to admin_community_post_boards_path(community_id: @community.id)
  end
end
