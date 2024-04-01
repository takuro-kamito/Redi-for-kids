class User::PostBoardsController < ApplicationController
  
  def index
    @community = Community.find(params[:community_id])
    @post_board = PostBoard.new
    @post_boards = @community.post_boards
    @users = User.all
  end

  def create
    @community = Community.find(params[:community_id]) # 選択したコミュニティを取得
    @post_boards = @community.post_boards
    @post_board = @community.post_boards.build(post_board_params) #buildメソッド　アソシエーションを使用して、モデルから取得し新しいオブジェクトを作成
    @post_board.user_id = current_user.id
    if @post_board.save
      flash[:notice] = "成功しました。"
      redirect_to user_community_post_boards_path(@community)
    else
      flash[:alert] = "登録に失敗しました。"
      render :index
    end
  end
  
    def destoroy
       @post_board = PostBoards.find(params[:id]) # 削除する投稿を取得
    if @post_boad.user_id == current_user.id # ログインユーザーと投稿のユーザーが一致しているかチェック
       @post_board.destroy #投稿削除
    end
       flash[:notice] = "削除しました。"
       redirect_to community_post_boards_path(params[:community_id]) # コミュニティの投稿一覧ページにリダイレクト
    end

    private

    def post_board_params
      params.require(:post_board).permit(:user_id, :community_id, :body,:favorite_id)
    end
end

