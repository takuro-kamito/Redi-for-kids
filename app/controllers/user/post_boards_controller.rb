class User::PostBoardsController < ApplicationController

  def index
    @community = Community.find(params[:community_id]) #@community`という変数に、`params[:community_id]`に対応する`Community`（コミュニティ）をデータベースから取得
    @post_board = PostBoard.new                        #PostBoard`（掲示板）のインスタンスを作成
    @post_boards = @community.post_boards
    @users = User.all
    @sort = params[:sort] #@sort`の値によって条件分岐
  if @sort == "newest"
    @post_boards = @post_boards.order(created_at: :desc) #@sort`が "newest" と等しい場合、`@post_boards`を`created_at`の降順でソート
  elsif @sort == "oldest"
    @post_boards = @post_boards.order(created_at: :asc) #@sort`が "oldest" と等しい場合、`@post_boards`を`created_at`の昇順でソート
  else
    @post_boards = @community.post_boards.order(created_at: :desc) #特定のコミュニティに関連する掲示板データを取得し、ソートの条件に従って並び替え
  end
  
  @users = User.all

  # 追加コード
  @users = @post_boards.map(&:user).uniq #@post_boards`は特定のコミュニティに関連する掲示板データのリストを表しています。そして、`map`メソッドを使って、`@post_boards`の各要素（つまり各掲示板）に対して以下の処理を実行
  end                                    #&:user`は、各掲示板の`user`というメソッドを呼び出すための短縮記法です。つまり、各掲示板のユーザーを取得
                                         #uniq`メソッドを使って、ユーザーリストから重複したユーザーを除去しています。これにより、`@users`には`@post_boards`に関連するユーザーの一意なリストが代入
  def create
    @community = Community.find(params[:community_id]) # 選択したコミュニティを取得
    @post_boards = @community.post_boards
    @post_board = @community.post_boards.build(post_board_params) #buildメソッド　アソシエーションを使用して、モデルから取得し新しいオブジェクトを作成
    @post_board.user_id = current_user.id
    if @post_board.save
      flash[:notice] = "成功しました。"
      redirect_to community_post_boards_path(@community)
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

